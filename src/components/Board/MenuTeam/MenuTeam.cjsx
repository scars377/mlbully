style = require './menuteam.styl'
{scx} = require 'utils'

SIZE = 260
LINE = 25
CIRC = (SIZE-LINE)*Math.PI

COLORS =
  down: '#06a5fd'
  like: '#ffce30'
  empty: '#0181de'

CIRCLE_PROPS =
  r:  (SIZE-LINE)/2
  cy: SIZE/2
  cx: SIZE/2
  strokeWidth: LINE
  fill: "none"


Ring = ({type, p=1})->
  cn = style["circle-#{type}"]
  <svg className={cn} width={SIZE} height={SIZE}>
    <g>
      <circle
        strokeDasharray = {"#{CIRC*p},#{CIRC}"}
        stroke = {COLORS[type]}
        {...CIRCLE_PROPS}
        />
    </g>
  </svg>


MenuTeam = ({down=0, like=0, name='TEAM1', id, onClick})->
  empty = down+like is 0
  cn = scx style,{'menuteam', empty}
  image = require "img/team#{id}.jpg"

  <div className={cn} onClick={onClick}>
    <div className={style.image} style={{backgroundImage:"url('#{image}')"}}/>
    <div className={style.name}>{name}</div>
    <div className={style.score}>{like-down}</div>

    {if empty
      <Ring type='empty'/>
    else
      [
        <Ring type='down' p={down / (down+like)}/>
        <Ring type='like' p={like / (down+like)}/>
      ]
    }

  </div>


module.exports = MenuTeam
