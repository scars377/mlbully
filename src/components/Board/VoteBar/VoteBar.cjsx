style = require './votebar.styl'

VoteBar = ({id,vote,max})->
	part = 100 * vote / max

	<div className={style.votebar}>
		<div className={style.part} style={{height:"#{part}%"}}>
			<div className={style.num}>{vote}</div>
		</div>

		<div className={style.score}>{id}</div>
	</div>

module.exports = VoteBar
