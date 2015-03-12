/* jshint node: true */
var http = require('http');
var port = (process.env.VCAP_APP_PORT || 3000);

var server = http.createServer(function (req, res) {
	res.writeHead(200, {
		"Content-Type": "text/plain"
	});
	res.end("Hello, Test!");
});

server.listen(port);
console.log("Server listening on port " + port);
