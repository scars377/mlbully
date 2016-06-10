style = require './board.styl'
VoteBar = require './VoteBar'
Scores = require './Scores'
Menu = require './Menu'
QR = require './QR'
Clicks = require './Clicks'


class Board extends React.Component
	state:
		connected: false
		team: -1
		votes: {}

	componentDidMount: ->
		@socket = io 'http://220.128.166.88',{path:'/mlbully/socket.io'}
		@socket.on 'connect',=>@socket.emit 'setboard'
		@socket.on 'ready',(team)=>
			@setState {connected: true},=>@teamSet team
		@socket.on 'click',=>@refs.clicks?.addClick()
		@socket.on 'teamset',@teamSet
		@socket.on 'voteget',@voteGet

	setTeam:(team)=>
		@socket.emit 'setteam',team

	teamSet:(team)=>
		@setState {team},=>
			if team isnt -1
				@socket.emit 'getvote',0,team

	voteGet:(team,data)=>
		@state.votes[team] = data
		@forceUpdate()

	render:->
		votes = @state.votes[@state.team] ? []

		max = votes.reduce ((a,b)->Math.max a,b),0
		max = 1 if max is 0

		if !@state.connected
			<div>nope</div>

		else
			teamid = @state.team
			teamid = '' if teamid is -1

			<div className={style.board}>

				<Menu open={@state.team is -1} setTeam={@setTeam}/>
				<QR/>
				<Clicks ref='clicks'/>

				<div className={style.head}>
					<div className={style.team} onClick={=>@setTeam -1}>{teamid}</div>
					<Scores votes={votes}/>
				</div>

				<div className={style.votes}>
					{for v,i in votes
						<VoteBar key={"bar#{i}"} id={i} vote={v} max={max}/>
					}
				</div>
			</div>


module.exports = Board
