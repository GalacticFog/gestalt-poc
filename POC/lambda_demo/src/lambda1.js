const request = require('request-promise-native');

module.exports.handler = async (event, context, callback) => {

    const options = {
        uri: 'http://www.google.com',
        resolveWithFullResponse: true
    }

    // const response = await request(options);

    callback(null, JSON.stringify({ event: event, context: JSON.parse(context), env: process.env }, null, 2));
};
