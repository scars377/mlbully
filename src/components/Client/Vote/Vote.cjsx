style = require './vote.styl'
VoteItem = require '../VoteItem'
Comment = require '../Comment'
Head = require '../Head'


Vote = ({voteIdx,votes,setVote})->
	{selected,comment} = vote = votes[voteIdx] ? {selected:-1,comment:''}

	<div className={style.vote}>

		<Head voteIdx={voteIdx} empty={!votes[voteIdx]?} />

		<div className={style.items}>
			{for i in [0..10]
				<VoteItem
					key = {"item#{i}"}
					id = {i}
					select = {(selected)->setVote voteIdx,{selected,comment}}
					selected = {i is selected}
				/>
			}
		</div>

		<Comment
			comment = {comment}
			setComment = {(comment)->setVote voteIdx,{selected,comment}}
		/>
	</div>





module.exports = Vote
