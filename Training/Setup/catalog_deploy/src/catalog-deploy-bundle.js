const { gestalt, actions } = require('gestalt-fog-sdk');
const request = require('request-promise-native');

module.exports.handler = async (event, context, callback) => {

    try {

        // console.log('Event: ' + event);
        // console.log('Context: ' + context);

        event = (event && event.length > 0) ? JSON.parse(event) : {};
        context = (context && context.length > 0) ? JSON.parse(context) : {};

        //
        // TODO - use Gestalt SDK to deploy the bundle
        //

        const body = {
            event: event,
            context: context
        }

        const response = {
            statusCode: 201,
            headers: {},
            body: JSON.stringify(body, null, 2)
        }

        callback(null, response);
    } catch (err) {
        const response = {
            statusCode: 500,
            headers: {},
            body: err.message
        }
        callback(null, response);
    }
};