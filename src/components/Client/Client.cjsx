style = require './client.styl'
Button = require './Button'


class Client extends React.Component
  state:
    team: -1
    vote: 0
    socket: false

  componentWillMount: ->
    localStorage['id'] ?= @genUID()
    @clientid = localStorage['id']

    @socket = io require('host'), {path:'/mlbully/socket.io'}
    @socket.on 'connect',@getVote
    @socket.on 'teamset',@getVote
    @socket.on 'voteget',@voteGet

  genUID:(len=16)->
    s = ''
    loop
      s += "#{Math.random()}".substr 2
      break if s.length>len
    return s.substr 0,len

  getVote:=>
    @socket.emit 'getvote', @clientid

  voteGet:(team, vote)=>
    @setState {team, vote, socket:true}

  setVote:(vote)=>
    return if @state.team is -1
    @setState {vote}
    @socket.emit 'setvote', @state.team, @clientid, vote

  click:=>
    return if @state.team is -1
    @socket.emit 'click'

  render:->
    teamname = if @state.team is -1
      "還沒開始投票"
    else
      "TEAM#{@state.team}"

    t = @state.team
    t = '' if t is -1
    teamimage = require "img/team#{t}.jpg"

    <div className={style.client}>
      <div className={style.container}>
        <div className={style.head}/>

        <div className={style.teamname}>
          {teamname}
        </div>

        <div className={style.teamimage} onClick={@click}>
          <img src={teamimage}/>
        </div>

        <div className={style.btns}>
          <Button
            type = 'down'
            vote = {@state.vote}
            disabled = {@state.team is -1}
            onClick = {=>@setVote -1}
            />
          <Button
            type = 'like'
            vote = {@state.vote}
            disabled = {@state.team is -1}
            onClick = {=>@setVote 1}
            />
        </div>
      </div>
    </div>

module.exports = Client
