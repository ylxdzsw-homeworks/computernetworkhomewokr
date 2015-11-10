dgram = require 'dgram'
counter = require './counter.js'
socket = dgram.createSocket 'udp4'
socket.bind '10086'

wSize = 5
pSize = 1

seg = counter 8

socket.on 'message', (msg, rinfo) ->
	id = msg.readInt8()
	other = '' + msg[1..]
	if id is seg.next()
		seg.go()
		console.log "#{other.length} bytes from #{rinfo.address}:#{rinfo.port}, Accepted    id:#{id}, content:#{other}"
	else
		console.log "#{other.length} bytes from #{rinfo.address}:#{rinfo.port}, Dropped     id:#{id}, content:#{other}"
	
	ACK = new Buffer(1)
	ACK.writeInt8 seg.get()
	socket.send ACK, 0, ACK.length, rinfo.port, rinfo.address

socket.on 'error', (err) ->
	console.log err

