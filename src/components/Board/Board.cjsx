style = require './board.styl'
Voting = require './Voting'
Menu = require './Menu'
QR = require './QR'
Clicks = require './Clicks'


class Board extends React.Component
  state:
    connected: false
    team: -1
    votes: {}

  componentDidMount: ->
    @socket = io require('host'), {path:'/mlbully/socket.io'}
    @socket.on 'connect',=>@socket.emit 'setboard'
    @socket.on 'ready',(team, votes)=>
      @setState {connected: true, votes},=>@teamSet team
    @socket.on 'click',=>@refs.clicks?.addClick()
    @socket.on 'teamset',@teamSet
    @socket.on 'voteget',@voteGet

  setTeam:(team)=>
    @socket.emit 'setteam',team

  teamSet:(team)=>
    @setState {team},=>
      if team isnt -1
        @socket.emit 'getvote',0,team

  voteGet:(team, data)=>
    @state.votes[team] = data
    @forceUpdate()

  render:->
    votes = @state.votes[@state.team] ? {}

    if !@state.connected
      <div>nope</div>

    else
      teamid = @state.team
      teamid = '' if teamid is -1

      <div className={style.board}>
        <Menu open={@state.team is -1} votes={@state.votes} setTeam={@setTeam}/>
        <Clicks ref='clicks'/>
        <Voting id={teamid} img={''} {...votes} onClick={=>@setTeam -1}/>
      </div>


module.exports = Board
