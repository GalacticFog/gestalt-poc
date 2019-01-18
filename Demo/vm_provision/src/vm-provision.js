const request = require('request-promise-native');

module.exports.handler = async (event, context, callback) => {
    console.log(`context: ${context}`);
    console.log(`event: ${event}`);

    context = (context && context.length > 0) ? JSON.parse(context) : {};

    if (context.method == 'GET') {

        // TODO: Check for required variables

        // Return the HTML form to the user
        return callback(null, {
            statusCode: 200,
            headers: {},
            body: getFormHtml()
        });
    }

    if (context.method == 'POST') {
        // Invoke the VM provisioning ...
        return callback(null, await doPost(event));
    }

    // Default - not handled
    return callback(null, error(Error().stack));
};

async function doPost(event) {

    // POST data is in the form of a query string, convert to JSON object
    event = queryStringToJSON(event);

    console.log(`event: ${JSON.stringify(event)}`);

    const token = process.env.TOKEN;
    const url = process.env.DOWNSTREAM_URL;
    const job = process.env.JOB;
    const method = process.env.DOWNSTREAM_HTTP_METHOD || 'POST'

    const requestId = event.requestId;
    delete event.requestId;

    const inputJson = JSON.stringify(event);
    const body = `job=${job}&token=${token}&InputJson=${inputJson}&ID=GF-${requestId}`

    console.log(`inputJson: ${inputJson}`);
    console.log(`body: ${body}`);

    try {
        const summary = await invokeUrl(url, method, body);
        
        // const message = JSON.stringify({
        //     requestId,
        //     request: {
        //         url,
        //         method,
        //         body
        //     },
        //     summary
        // }, null, 2);

        const message = `Success - Request ID '${requestId}' submitted successfully.`;

        return success(message);
    } catch (err) {
        return error(JSON.stringify({
            requestId,
            request: {
                url,
                method,
                body
            },
            error: err
        }, null, 2));
    }
}

async function invokeUrl(url, method, body) {
    const options = {
        method: method,
        resolveWithFullResponse: true,
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Content-Length': body.length
        },
        timeout: 10000,
        body: body
    }

    const start = Date.now();

    console.log(`Invoking ${url}...`)

    const summary = [];

    const resp = await request({ uri: url, ...options });

    const elapsed = Date.now() - start;

    console.log('resp.body: ' + resp.body);
    console.log('typeof resp.body: ' + (typeof resp.body));
    console.log(`${url} returned a ${resp.statusCode} and took ${elapsed} ms...`)

    summary.push({
        timestamp: start,
        elapsed: elapsed,
        downstream_url: url,
        downstream_response_statusCode: resp.statusCode,
        downstream_response_headers: resp.headers,
        downstream_response_body: resp.body
    });

    return summary;
}

function success(body) {
    const response = {
        statusCode: 200,
        headers: {},
        body: successHtml(body)
    };

    return response;
}

function error(body) {
    const response = {
        statusCode: 400,
        headers: {},
        body: errorHtml(body)
    };

    return response;
}

function queryStringToJSON(qs) {
    const pairs = qs.split('&');

    const result = {};
    pairs.forEach(function (pair) {
        pair = pair.split('=');
        result[pair[0]] = decodeURIComponent(pair[1] || '');
    });

    return JSON.parse(JSON.stringify(result));
}

function generateToken() {
    const length = 8
    const possible = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    let text = "";

    for (var i = 0; i < length; i++) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }

    return text;
}

function getFormHtml() {

    const requestToken = generateToken();

    return `
<html>
<head>
    <title>'IaC Provisioning - Virtual Machine Instance'}</title>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
</head>
<body class="bg-light">
    <div class="container">
        <div class="row" style="margin:100px;">
            ${getLogoHtml()}
            <form id="form1"  method="POST">
                <h2>IaC Provisioning - Virtual Machine</h2>
                
                <input id="requestId" name="requestId" type="hidden" value="${requestToken || 'NoRequestToken'}">

                <div class="form-group">
                    <label for="Cloud">Hosting Platform</label>
                    <select class="form-control" id="Cloud" name="Cloud">
                        ${getCloudOptionsHtml()}
                    </select>
                </div>
                
                <label for="Region">Region</label>
                <input id="Region" name="Region" type="text" placeholder="Region" class="form-control"  style="margin-bottom:16px; min-width:150px;"></input>
                
                <label for="Project">Project</label>
                <input id="Project" name="Project" type="text" placeholder="Project" class="form-control"  style="margin-bottom:16px; min-width:150px;"></input>
                
                <label for="Repository">Repository</label>
                <input id="Repository" name="Repository" type="text" placeholder="Repository" class="form-control"  style="margin-bottom:16px; min-width:150px;"></input>
                
                <label for="Branch">Branch</label>
                <input id="Branch" name="Branch" type="text" placeholder="Git Branch Name" class="form-control"  style="margin-bottom:16px; min-width:150px;"></input>

                <div class="form-group">
                    <label for="Size">VM Size</label>
                    <select class="form-control" id="Size" name="Size">
                        <option>small</option>
                        <option>medium</option>
                        <option>large</option>
                    </select>
                </div>

                <label for="OStype">OS Type</label>
                <div class="radio">
                    <label><input type="radio" name="OStype" value="rhel7" checked>RHEL 7.x</label>
                </div>
                <div class="radio">
                    <label><input type="radio" name="OStype" value="windows2016">Windows 2016</label>
                </div>


                <div class="form-group">
                    <label for="nas_enabled">Storage Settings</label>

                    <label class="checkbox-inline"><input id="nas_enabled" name="nas_enabled" type="checkbox" value="">NAS enabled</label>

                    <input id="NASsize" name="NASsize" type="number" placeholder="NAS Size (GiB)" class="form-control"  style="margin-bottom:16px; min-width:150px;"></input>
                </div>

                <button type="submit" method="POST">Submit</button>
            </form>
        </div>
    </div>
</body>
</html>   
    `
}

function getCloudOptionsHtml() {
    const str = process.env.CLOUD_OPTIONS || 'AWS,Azure,Google';

    let html = '';
    const items = str.split(',');
    for (let item of items) {
        html += `<option>${item}</option>\n`;
    }
    return html;
}

function moreHtml(params) {
    if (params.requestId) {
        return `
<a href="?action=checkResult&requestId=${params.requestId}">Link RequestID=${params.requestId}</a>
`;
    }

    return '';
}

function errorHtml(msg) {
    return `
<html>
<head>
    <title>Error Occurred</title>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
</head>
<body class="bg-light">
    <div class="container">
        <div class="row" style="margin:100px;">
            <div>
            ${getLogoHtml()}
            </div>
            <div>
            An error occurred:
                <pre>
                    ${msg}
                </pre>
            </div>
            <a href="javascript:history.back()">Go Back</a>
        </div>
    </div>
</body>
</html>   
`
}

function successHtml(msg) {
    return `
<html>
<head>
    <title>Success</title>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
</head>
<body class="bg-light">
    <div class="container">
        <div class="row" style="margin:100px;">
            <div>
            ${getLogoHtml()}
            </div>
            <div>
                <pre>
                    ${msg}
                </pre>
            </div>
            <a href="javascript:history.back()">Go Back</a>
        </div>
    </div>
</body>
</html>   
`
}

function successHtml_withResponseDetails(msg) {
    return `
<html>
<head>
    <title>Success</title>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
</head>
<body class="bg-light">
    <div class="container">
        <div class="row" style="margin:100px;">
            <div>
            ${getLogoHtml()}
            </div>
            <div>
                <pre>
                    ${msg}
                </pre>
            </div>
            <a href="javascript:history.back()">Go Back</a>
        </div>
    </div>
</body>
</html>   
`
}

function getLogoHtml() {
    if (process.env.LOGO_IMAGE) {
        return `<img src="${process.env.LOGO_IMAGE}">`
    }
    return '';
}