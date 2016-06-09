style = require './vote.styl'
{scx} = require 'utils'

VoteItem = ({id, select, selected})->
	className = scx style,{
		'item'
		"item--wide": id is 10
		"item--selected": selected
	}
	<div className={className} onClick={->select id}>
		<span>{id}</span>
	</div>


Vote = ({vote,setVote})->
	<div className={style.vote}>
		{for i in [0..10]
			props =
				key: "item#{i}"
				id: i
				select: setVote
				selected: i is vote
			<VoteItem {...props}/>
		}
	</div>





module.exports = Vote
