style = require './board.styl'

class Board extends React.Component
	state:
		len:0
		avg:0

	componentDidMount: ->
		@socket = io()
		@socket.on 'state', @getState

	getState:(state)=>
		@setState state
	render:->
		<div className={style.board}>
			{@state.len}/{@state.avg}
		</div>


module.exports = Board
