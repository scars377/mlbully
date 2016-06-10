style = require './qr.styl'
{scx} = require 'utils'

class QR extends React.Component
	state:
		open: false

	toggle:=>
		@setState open:!@state.open

	render:->
		className = scx style,{
			'qr'
			'qr--open': @state.open
		}
		<div className={className} onClick={@toggle}/>

module.exports = QR
