style = require './menu.styl'
{scx} = require 'utils'

MenuTeam = require '../MenuTeam'

Menu = ({open, votes, setTeam})->
  className = scx style,{
    'menu'
    'menu--open': open
  }

  <div className={className}>
    <div className={style.head}/>
    <div className={style.teams}>
      {for t in [1..6]
        props =
          id: t
          key: "menu-team-#{t}"
          down: votes[t]?.down ? 0
          like: votes[t]?.like ? 0
          name: "TEAM#{t}"
          image: ''
          onClick: do(t)->->setTeam t
        <MenuTeam {...props}/>
      }
    </div>
  </div>

module.exports = Menu
