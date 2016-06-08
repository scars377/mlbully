style = require './voteitem.styl'
{scx} = require 'utils'

VoteItem = ({id, select, selected})->
	className = scx style,{
		'item'
		"item--selected": selected
	}
	<div className={className} onClick={->select id}>
		<span>{id}</span>
	</div>

module.exports = VoteItem
