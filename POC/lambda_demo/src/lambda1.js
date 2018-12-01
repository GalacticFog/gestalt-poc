const request = require('request-promise-native');

module.exports.handler = async (event, context, callback) => {

    // const options = {
    //     uri: 'http://www.galacticfog.com',
    //     resolveWithFullResponse: true
    // }

    // const response = await request(options);

    // callback(null, response.body);

    // callback(null, JSON.stringify({ event: event, context: JSON.parse(context), env: process.env }, null, 2));


    // const timeout = ms => new Promise(res => setTimeout(res, ms))

    // console.error("Waiting a time...")

    // await timeout(5000);

    console.log('This is a log message');

    console.error('This is another log message');

    const response = {
        statusCode: 201,
        headers: { 'test-header': 'test123' },
        body: 'Successful test 2'
    }

    callback(null, JSON.stringify(response, null, 2));
};



