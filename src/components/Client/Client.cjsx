style = require './client.styl'
Top = require './Top'
Vote = require './Vote'


class Client extends React.Component
	state:
		fb: {}
		votes: []
		voteIdx: 0

	setVote:(voteIdx,vote)=>
		votes = @state.votes.concat()
		votes[voteIdx] = vote
		@setState {votes,voteIdx}

	render:->
		<div className={style.client}>
			{if @state.fb?
				<Vote
					voteIdx = {@state.voteIdx}
					votes = {@state.votes}
					setVote = {@setVote}
				/>
			else
				<Top setFB={(fb)=>@setState {fb}}/>
			}
		</div>

module.exports = Client
