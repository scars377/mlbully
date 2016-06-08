style = require './comment.styl'
{scx} = require 'utils'

class Comment extends React.Component
	state:
		comment: ''

	constructor:({comment})->
		@state = {comment}

	change:(e)=>
		@setState {comment:e.target.value}

	keydown:(e)=>
		@confirm() if e.keyCode is 13

	cancel:=>
		@setState {comment:@props.comment}

	confirm:=>
		@props.setComment @state.comment

	render:->
		changed = @state.comment isnt @props.comment
		inputClass = scx style,{
			'input'
			'input--active': changed
		}
		btnClass = scx style,{
			'btn'
			'btn--active': changed
		}

		<div className={style.comment}>
			<input
				type = 'text'
				className = {inputClass}
				value = {@state.comment}
				placeholder = '評論'
				onChange = {@change}
				onKeyDown = {@keydown}
				onClick = {(e)->e.target.select()}
			/>
			<div className={"#{btnClass} #{style.cancel}"} onClick={@cancel}/>
			<div className={"#{btnClass} #{style.confirm}"} onClick={@confirm}/>
		</div>


module.exports = Comment
