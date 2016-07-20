style = require './button.styl'
{scx} = require 'utils'

Button = ({type, vote, disabled, onClick})->
  v = if type is 'down' then -1 else 1

  cn = scx style,{
    "btn"
    "btn-#{type}"
    "press": vote is v
    "gray": disabled or vote is -v
  }
  <div className={cn} onClick={onClick}/>


module.exports = Button
