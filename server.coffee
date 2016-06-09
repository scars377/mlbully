port = 3000
ip = 'localhost'
# ip = '192.168.253.151'

express = require 'express'
app = express()
server = app.listen port,ip,->console.log 'server start'
io = require('socket.io')(server)

app.use express.static 'dist'

votes = {}
boards = {}
data = (0 for i in [0..10])

io.on 'connect',(socket)->
	id = socket.id.replace '#/',''

	socket.on 'setboard',->
		boards[id] = socket
		socket.emit 'votes',data

		socket.on 'disconnect',->
			delete boards[id]

	socket.on 'getvote',(fbid)->
		socket.emit 'voteget',votes[fbid]

	socket.on 'vote',(fbid,vote)->
		votes[fbid] = vote

		data[i] = 0  for i in [0..10]
		data[v] += 1 for _,v of votes

		for _,board of boards
			board.emit 'votes',data
