style = require './voting.styl'

Voting = ({like=0, down=0, id, image, onClick})->
  if id isnt ''
    video = require "vid/team#{id}.mp4"

  <div className={style.voting}>

    <div className={style.head} onClick={onClick}/>
    <div className={style.teamname}>{"TEAM#{id}"}</div>

    <div className={style.teamimage}>
      <video src={video} autoPlay loop/>
    </div>

    <div className={style.scores}>

      <div className={style.scoreDown}>
        <img className={style.scoreDownIcon} src={require 'img/b-down-c.png'}/>
        <img className={style.scoreDownWord} src={require 'img/b-down-w.png'}/>
        <div className={style.scoreDownNum}>{down}</div>
      </div>

      <div className={style.scoreLike}>
        <img className={style.scoreLikeIcon} src={require 'img/b-like-c.png'}/>
        <img className={style.scoreLikeWord} src={require 'img/b-like-w.png'}/>
        <div className={style.scoreLikeNum}>{like}</div>
      </div>

    </div>
  </div>


module.exports = Voting
