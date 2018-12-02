const request = require('request-promise-native');

module.exports.handler = async (event, context, callback) => {

    const timeout = ms => new Promise(res => setTimeout(res, ms))

    console.error("Waiting a time...")

    await timeout(5000);

    throw Error('This is an error caused by \'throw Error(msg)\' !');
};
