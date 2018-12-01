const request = require('request-promise-native');

module.exports.handler = async (event, context, callback) => {

    console.log('Event: ' + event);
    console.log('Context: ' + context);

    event = (event && event.length > 0) ? JSON.parse(event) : {};

    const timeout = ms => new Promise(res => setTimeout(res, ms))

    console.log("Waiting a time...")

    await timeout(200);

    const response = {
        statusCode: 201,
        headers: { 'test-header2': 'test123' },
        body: `The Upstream input was '${event.body}'.`
    }

    callback(null, response);
};
