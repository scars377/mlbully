style = require './scores.styl'

class Scores extends React.Component
	state:
		score: 0

	componentWillReceiveProps: ({votes}) ->
		sum = 0
		num = 0
		for v,i in votes
			sum += v*i
			num += v
		num = 1 if num is 0

		@target = sum / num

		clearTimeout @timer
		@setScore()

	setScore:=>
		d = (@target - @state.score)*.1
		if -.01 < d < .01
			@setState {score:@target}
		else
			@setState {score:@state.score+d}, @scoreSet

	scoreSet:=>
		@timer=setTimeout @setScore,20

	render:->
		@state.score
		left = @state.score|0
		right = @state.score.toFixed(1).substr(-2)

		<div className={style.scores}>
			<span className={style.left}>{left}</span>
			<span className={style.right}>{right}</span>
		</div>

module.exports = Scores
