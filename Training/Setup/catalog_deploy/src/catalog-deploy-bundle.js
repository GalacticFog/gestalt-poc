const { gestalt, actions } = require('gestalt-fog-sdk');
const request = require('request-promise-native');

module.exports.handler = async (event, ctx, callback) => {

    try {
        console.log('Event: ' + event);
        console.log('Context: ' + ctx);

        event = parse(event);
        ctx = parse(ctx);

        await initialize();

        const context = getContext(event);

        const data = JSON.parse(event.payload);

        console.log('Applying resources...');

        const { succeeded, failed } = await actions.applyResources(context, data.resources, data.options, data.config);

        console.log('Showing results...');

        const body = {
            succeeded, failed
        }

        const response = {
            statusCode: 200,
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

function parse(o) {
    return (o && o.length > 0) ? JSON.parse(o) : {};
}

function getContext(event) {
    // const contextPath = ctx.context.contextMeta.fqon + '/' + ctx.context.workspace.name + '/' + ctx.context.environment.name;
    return {
        org: {
            fqon: event.context.contextMeta.fqon
        },
        workspace: {
            id: event.context.contextMeta.workspaceId
        },
        environment: {
            id: event.context.contextMeta.environmentId
        },
    };
}


async function initialize() {
    // Configuration params
    gestalt.configure({
        gestalt_url: 'required-but-not-used',
        meta_url: 'http://gestalt-meta.gestalt-system.svc.cluster.local:10131',
        security_url: 'http://gestalt-security.gestalt-system.svc.cluster.local:9455',
    })

    // Do login
    const res = await gestalt.login({
        username: 'admin',
        password: 'gestaltpoc!'
    });
}