style = require './vote.styl'
{scx} = require 'utils'

VoteItem = ({id, select, selected})->
	className = scx style,{
		'item'
		"item--selected": selected
	}
	<div className={className} onClick={->select id}>
		<span>{id}</span>
	</div>


Vote = ({team,vote,setVote,click})->
	t = if team is -1 then '-' else team

	<div className={style.vote}>
		<div className={style.team} onMouseDown={click}>
			<span>{t}</span>
		</div>

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
