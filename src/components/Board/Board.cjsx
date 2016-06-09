style = require './board.styl'
VoteBar = require './VoteBar'
Scores = require './Scores'

class Board extends React.Component
	state:
		votes: (0 for i in [0..10])
		# votes: (Math.random()*10|0 for i in [0..10])

	componentDidMount: ->
		@socket = io()
		@socket.on 'connect',=>@socket.emit 'setboard'
		@socket.on 'votes',(votes)=>@setState {votes}

	render:->
		max = @state.votes.reduce (a,b)->Math.max a,b
		max = 1 if max is 0

		<div className={style.board}>
			<div className={style.head}>
				<div className={style.team}/>
				<Scores votes={@state.votes}/>
			</div>

			{for v,i in @state.votes
				<VoteBar key={"bar#{i}"} id={i} vote={v} max={max}/>
			}
		</div>


module.exports = Board
