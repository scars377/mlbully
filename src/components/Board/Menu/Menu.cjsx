style = require './menu.styl'
{scx} = require 'utils'

teams = require 'teams'

Menu = ({open,setTeam})->
	className = scx style,{
		'menu'
		'menu--open': open
	}

	<div className={className}>
		{for t in [1..6]
			props = {
				key: "menu-team-#{t}"
				className: style.team
				onClick: do(t)->->setTeam t
			}
			<div {...props}>{t}</div>
		}
	</div>

module.exports = Menu
