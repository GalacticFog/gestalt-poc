const request = require('request-promise-native');

module.exports.handler = async (event, context, callback) => {

    const timeout = ms => new Promise(res => setTimeout(res, ms))

    console.error("Waiting a time...")

    await timeout(5000);

    const response = {
        statusCode: 201,
        headers: { 'test-header': 'test123' },
        body: 'Output from Lambda 2'
    }

    callback(null, JSON.stringify(response, null, 2));
};
