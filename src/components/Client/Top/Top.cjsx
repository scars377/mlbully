style = require './top.styl'
{scx} = require 'utils'

class Top extends React.Component
	state:
		loading: true
		logged: false

	constructor:->
		FB.init {
			appId	: '1723474577941477'
			xfbml	: true
			version: 'v2.6'
		}

	componentDidMount: ->
		FB.getLoginStatus @loginResponse

	click:=>
		@setState {loading:true},=>
			FB.login @loginResponse

	loginResponse:({status,authResponse})=>
		if status is 'connected'
			{userID,accessToken} = authResponse
			@props.setFB {userID,accessToken}
		else
			@setState {loading:false, logged:false}

	render:->
		type = if @state.loading
			'loading'
		else if @state.logged
			'complete'
		else
			'login'

		className = scx style,{'inner',"#{type}"}

		<div className={style.top}>
			<div className={className} onClick={@click} />
		</div>


module.exports = Top
