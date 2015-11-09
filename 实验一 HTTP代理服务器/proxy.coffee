net = require 'net'

HOST = '127.0.0.1'
PORT = 10086

server = (sock) ->
	console.log 'a connetion made'
	client = new net.Socket
	sock.on 'data', (data) ->
		data = '' + data
		if connInfo = data.match /(GET|POST) (.*) HTTP/
			console.log getHeaders(data)
			fetchFromRemote client, connInfo[2].split('/')[2], data, (data) ->
				sock.write data
		else
			console.error 'unexpected' + data
	sock.on 'close', (err) ->
		console.log "a socket closed"
	sock.on 'error', (e) -> console.log "an error happend:" + e

fetchFromRemote = (sock, host, data, cb) ->
	sock.connect 80, host, ->
		console.log "connected to #{host}"
		sock.end data
	sock.on 'data', (data) ->
		cb data
	sock.on 'error', (e) -> console.log "an error happend:" + e

getHeaders = (data) ->
	headers = data.split '\n'
	a = headers.indexOf('')
	headers = headers[0..a]
	return headers

net.createServer server
	.listen PORT, HOST