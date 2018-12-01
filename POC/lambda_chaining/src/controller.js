const request = require('request-promise-native');

module.exports.handler = async (event, context, callback) => {

    console.log('Event: ' + event);
    console.log('Context: ' + context);

    context = JSON.parse(context);

    const urls = [];

    let serviceUrl = process.env.LASER_SERVICE_URL;
    if (!serviceUrl) throw Error(`LASER_SERVICE_URL is not defined`);

    console.log(`LASER_SERVICE_URL = ${serviceUrl}`);

    console.log(`Collecting all lambda IDs from environment...`);
    let i = 0;
    while (true) {
        i++;

        const lambdaId = process.env[`LAMBDA_${i}`];
        if (!lambdaId) break;

        const url = `${serviceUrl}/lambdas/${lambdaId}/invokeSync`;
        urls.push(url);

        console.log(`Found LAMBDA_${i}: ${lambdaId} --> ${url}`);
    }

    const summary = [];

    const options = {
        method: 'POST',
        resolveWithFullResponse: true,
        headers: context.headers || {},
        body: ''
    }    

    console.log(`Will process ${urls.length} urls...`);
    for (let url of urls) {

        const start = Date.now();

        console.log(`Invoking ${url}...`)

        const resp = await request({ uri: url, ...options });

        const elapsed = Date.now() - start;

        console.log('resp.body: ' + resp.body);

        console.log(`${url} returned a ${resp.statusCode} and took ${elapsed} ms...`)

        summary.push({
            url: url,
            elapsed: elapsed,
            statusCode: resp.statusCode,
            timestamp: start,
            body: resp.body
        });

        // Collect headers
        options.headers = Object.assign(options.headers, JSON.parse(resp.body).headers);
        options.body = resp.body; // Use response from this call for the next downstream call
    }

    console.log(`Wrapping up, got ${summary.length} results`);

    const response = {
        statusCode: 200,
        headers: options.headers,
        body: JSON.stringify(summary, null, 2)
    }

    callback(null, response);
};