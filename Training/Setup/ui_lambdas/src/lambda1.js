const request = require('request-promise-native');

module.exports.handler = async (event, context, callback) => {

    console.log(`context: ${context}`);
    console.log(`event: ${event}`);

    event = (event && event.length > 0) ? JSON.parse(event) : {};
    context = (context && context.length > 0) ? JSON.parse(context) : {};

    if (context.method == 'GET') {
        const response = {
            statusCode: 200,
            headers: {},
            body: getHtml()
        };

        return callback(null, response);
    }

    if (context.method == 'POST') {
        callback(null, sendSms(context, event));
        return;
    }

    callback("Method not found", null);



    // const response = {
    //     statusCode: 201,
    //     headers: {},
    //     body: JSON.stringify(data)
    // }

    // callback(null, data);
};


// function doPost(url) {
//     const options = {
//         method: 'POST',
//         resolveWithFullResponse: true,
//         headers: context.headers || {},
//         timeout: 10000,
//         body: ''
//     }

//     const start = Date.now();

//     console.log(`Invoking ${url}...`)

//     const summary = [];

//     try {

//         const resp = await request({ uri: url, ...options });

//         const elapsed = Date.now() - start;

//         console.log('resp.body: ' + resp.body);
//         console.log('typeof resp.body: ' + (typeof resp.body));
//         console.log(`${url} returned a ${resp.statusCode} and took ${elapsed} ms...`)

//         summary.push({
//             timestamp: start,
//             elapsed: elapsed,
//             downstream_url: url,
//             downstream_statusCode: resp.statusCode,
//             downstream_headers: resp.headers,
//             downstream_response: JSON.parse(resp.body)
//         });

//         // Collect headers
//         options.headers = Object.assign(options.headers, JSON.parse(resp.body).headers);
//         options.body = resp.body; // Use response from this call for the next downstream call
//     } catch (err) {

//     }
// }

function getHtml() {

        var MultiString = function (f) {
            return f.toString().split('\n').slice(1, -1).join('\n');
        };

        var ux = MultiString(function () {/**<html>
<head>
    <title>Send message</title>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
</head>
<body class="bg-light">
    <div class="container">
        <div class="row" style="margin:100px;">
            <h2>Send message</h2>
            <textarea id="message" placeholder="Message" autofocus="autofocus" onblur="messageBlur()" onfocus="messageFocused()" class="form-control" style="margin-bottom:16px; min-width:150px;"></textarea>
            <button onclick="sendClick()" class="btn btn-primary" style="width:150px;">Send</button>

            <div id="status" style="margin-left:32px;"></div>
        </div>
    </div>

    <script>
        
        function messageFocused() {
            $('#status').text('');
        }

        function sendClick() {
            var msg = $('#message').val();

            if (!msg) {
                $('#status').text('Write some text');
                return;
            }

            $('#status').text('Sending...');
            var url = '';
            $.post(url, JSON.stringify({ msg: msg }), function (data, error) {
                $('#status').text(data);
            }).fail(
                function (error) {                    
                    $('#status').text('Error code: ' + error.status);
                });
        }

    </script>
</body>
</html>
 **/});

        return ux;
    }
