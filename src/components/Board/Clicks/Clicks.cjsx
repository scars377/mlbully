style = require './clicks.styl'

class Clicks extends React.Component
	addClick:->
		c = $('<div/>')
			.addClass style.click
			.css {
				left: "#{(Math.random()*60+20).toFixed(2)}%"
				top:  "#{(Math.random()*60+20).toFixed(2)}%"
			}
			.on 'animationend',->$(@).remove()
			.appendTo ".#{style.clicks}"

	render:->
		<div className={style.clicks}/>

module.exports = Clicks
