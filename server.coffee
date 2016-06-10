port = 4002
# ip = 'localhost'
# ip = '192.168.253.151'

express = require 'express'
app = express()
server = app.listen port,->console.log 'server start'
io = require('socket.io')(server,{path:'/mlbully/socket.io'})
fs = require 'fs'

{votes={},team=-1} = require './save.json'
saveTimer = null

doSave = ->
	fs.writeFile './save.json',JSON.stringify {votes,team},null,'\t','utf8'

save = ->
	clearTimeout saveTimer
	saveTimer = setTimeout doSave,3000


board = null
# app.use '/mlbully',express.static 'dist'
# app.use '/mlbully/b',(r,s)->s.redirect '/mlbully/board.html'

io.on 'connect',(socket)->
	id = socket.id.replace '#/',''

	socket.on 'setboard',->
		return if board?

		board = socket
		socket.emit 'ready',team

		socket.on 'disconnect',->
			board = null

		socket.on 'setteam',(i)->
			team = i
			io.emit 'teamset',team
			save()

	socket.on 'getvote',(fbid,teamid)->
		if fbid is 0
			data = (0 for i in [0..10])
			data[v] += 1 for _,v of votes[teamid] ? {}
			board?.emit 'voteget',teamid,data

		else
			socket.emit 'voteget',team,votes[team]?[fbid]


	socket.on 'setvote',(teamid,fbid,vote)->
		return if teamid is -1

		votes[teamid] ?= {}
		votes[teamid][fbid] = vote

		data = (0 for i in [0..10])
		data[v] += 1 for _,v of votes[teamid]
		board?.emit 'voteget',teamid,data

		save()

	socket.on 'click',->
		board?.emit 'click'
