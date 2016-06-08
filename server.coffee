port = 3000
ip = '192.168.253.151'

express = require 'express'
app = express()
server = app.listen port,ip,->console.log 'server start'
io = require('socket.io')(server)

app.use express.static 'dist'

votes = {}
io.on 'connect',(socket)->
	id = socket.id.replace '#/',''

	socket.on 'select',(i)->
		votes[id] = i

		scores = (score for _,score of votes)
		len = scores.length
		avg = scores.reduce ((a,b)->a + b/len),0

		console.log {len,avg}
		io.emit 'state', {len, avg}
