style = require './client.styl'
Top = require './Top'
Vote = require './Vote'


class Client extends React.Component
	state:
		fbid: null
		team: -1
		vote: null
		socket: false

	setupSocket:=>
		@socket = io 'http://220.128.166.88',{path:'/mlbully/socket.io'}
		@socket.on 'connect',@getVote
		@socket.on 'teamset',@getVote
		@socket.on 'voteget',@voteGet

	getVote:=>
		@socket.emit 'getvote', @state.fbid

	voteGet:(team,vote)=>
		@setState {team,vote,socket:true}

	setFB:(fbid)=>
		@setState {fbid},@setupSocket

	setVote:(vote)=>
		return if @state.team is -1
		@setState {vote}
		@socket.emit 'setvote',@state.team,@state.fbid,vote

	click:=>
		@socket.emit 'click'

	render:->
		<div className={style.client}>
			{if !@state.fbid
				<Top setFB={@setFB}/>

			else if !@state.socket?
				null

			else
				<Vote
					team = {@state.team}
					vote = {@state.vote}
					setVote = {@setVote}
					click = {@click}
				/>
			}
		</div>

module.exports = Client
