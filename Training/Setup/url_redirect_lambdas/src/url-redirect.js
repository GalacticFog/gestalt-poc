const map = {
    'gf': 'http://galacticfog.com',
    'test2': 'https://test.galacticfog.com'
}

module.exports.handler = async (event, context, callback) => {
    console.log(`context: ${context}`);
    console.log(`event: ${event}`);

    event = (event && event.length > 0) ? JSON.parse(event) : {};
    context = (context && context.length > 0) ? JSON.parse(context) : {};

    if (context.method == 'GET') {
        const key = getParam(context, 'id');

        if (key) {
            const targetLocation = map[key];

            if (targetLocation) {
                // Send a redirect
                return callback(null, {
                    statusCode: 302,
                    headers: {
                        'Location': targetLocation
                    },
                    body: ''
                });
            }

            return callback(null, {
                statusCode: 404,
                headers: {},
                body: `No location found for id ${key}`
            });
        }

        return callback(null, {
            statusCode: 404,
            headers: {},
            body: `No 'id' parameter found in query string`
        });
    }
    // Default - not handled
    return callback(null, {
        statusCode: 404,
        headers: {},
        body: `Error - not handled. Context: ${context}`
    });
};

function getParam(context, name) {
    if (context.params && context.params[name]) {
        return context.params[name][0]
    }
    return null;
}
