dgram = require 'dgram'
counter = require './counter.js'
socket = dgram.createSocket 'udp4'
socket.bind()

wSize = 5
pSize = 1
timeout = 500

seg = counter 8
lastACK = counter 8
startPoint = 0

msg = new Buffer "hello world"
packets = do ->
	i = 0
	while i < msg.length
		i += pSize
		msg.slice i-pSize, i

startTick = do ->
	handle = null
	() ->
		clearTimeout handle if handle
		for i in [0...lastACK.minus lastACK.getbase()]
			packets.shift()
		return console.log "finished!" if packets.length is 0
		resnum = 0
		lastACK.rebase lastACK.get()
		seg.set lastACK.get()
		sendWindow()
		handle = setTimeout startTick, timeout

sendOne = (buffer, id) ->
	s = new Buffer(1)
	s.writeInt8 id
	data = Buffer.concat [s, buffer]
	socket.send data, 0, data.length, 10086, '127.0.0.1'

sendWindow = () ->
	seg.set lastACK.get()
	console.log "sendding window lastACK:#{lastACK.get()}"
	for i in [0...wSize]
		sendOne packets[i], seg.go() if packets[i]?

socket.on 'message', (msg, rinfo) ->
	ACK = msg.readInt8()
	if not lastACK.gt ACK
		lastACK.go() while lastACK.get() isnt ACK
	console.log "receive ACK:#{ACK} lastACK:#{lastACK.get()}"

socket.on 'error', (err) -> console.log err

startTick()