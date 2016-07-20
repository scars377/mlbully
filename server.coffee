port = 4002
# ip = 'localhost'
# ip = '192.168.253.151'

express = require 'express'
app = express()
server = app.listen port,->console.log "server start at #{port}"
path = require 'path'
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
app.use '/mlbully',express.static 'dist'
app.use '/mlbully/_____',(r,s)->s.sendFile path.resolve 'dist/board.html'

getVoteData = (v={})->
  data = {down:0, like:0}
  for clientid, vote of v
    if vote is -1
      data.down += 1
    else if vote is 1
      data.like += 1
  return data

emitTeamData = (teamid)->
  data = getVoteData votes[teamid]
  board?.emit 'voteget', teamid, data

io.on 'connect',(socket)->
  id = socket.id.replace '#/',''

  socket.on 'setboard',->
    board = socket

    socket.emit 'ready', team, do->
      data = {}
      data[i] = getVoteData votes[i] for i in [1..6]
      return data


    socket.on 'disconnect',->
      board = null

    socket.on 'setteam',(i)->
      team = i
      io.emit 'teamset',team
      save()

  socket.on 'getvote',(clientid, teamid)->
    if clientid is 0
      emitTeamData teamid
    else
      socket.emit 'voteget', team, votes[team]?[clientid] ? 0


  socket.on 'setvote',(teamid, clientid, vote)->
    return if teamid is -1

    votes[teamid] ?= {}
    votes[teamid][clientid] = vote

    emitTeamData teamid
    save()

  socket.on 'click',->
    board?.emit 'click'
