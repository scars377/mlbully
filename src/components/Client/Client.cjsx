style = require './client.styl'
Top = require './Top'
Vote = require './Vote'


class Client extends React.Component
	state:
		fbid: null
		vote: null
		socket: false

	constructor:->
		@socket = io()
		@socket.on 'connect',=>@setState socket:true
		@socket.on 'voteget',@voteGet

	setFB:(fbid)=>
		@setState {fbid}
		@socket.emit 'getvote',fbid

	voteGet:(vote)=>
		@setState {vote}

	setVote:(vote)=>
		@setState {vote}
		@socket.emit 'vote',@state.fbid,vote


	render:->
		<div className={style.client}>
			{if !@state.socket?
				null
			else if !@state.fbid
				<Top setFB={@setFB}/>
			else
				<Vote vote={@state.vote} setVote={@setVote}/>
			}
		</div>

module.exports = Client
