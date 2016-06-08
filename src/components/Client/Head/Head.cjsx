style = require './head.styl'

Head = ({voteIdx,empty})->
	<div className={style.head}>
		{voteIdx}
		{if empty then 'empty' else 'voted'}
	</div>


module.exports = Head
