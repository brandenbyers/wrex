# Description:
#   Have Hubot remind you to do standups.
#   hh:mm must be in the same timezone as the server Hubot is on. Probably UTC.
#
#   This is configured to work for Hipchat. You may need to change the 'create standup' command
#   to match the adapter you're using.
#
# Configuration:
#  HUBOT_STANDUP_PREPEND
#
# Dependencies:
#   underscore
#   cron

###jslint node: true###

cronJob = require('cron').CronJob
chrono = require('chrono-node')
moment = require('moment')
_ = require('underscore')

module.exports = (robot) ->
  # Compares current time to the time of the standup
  # to see if it should be fired.
  standupShouldFire = (standup) ->
    standupTime = standup.time
    utc = standup.utc
    now = new Date
    currentHours = undefined
    currentMinutes = undefined
    if utc
      currentHours = now.getUTCHours() + parseInt(utc, 10)
      currentMinutes = now.getUTCMinutes()
      if currentHours > 23
        currentHours -= 23
    else
      currentHours = now.getHours()
      currentMinutes = now.getMinutes()
    standupHours = standupTime.split(':')[0]
    standupMinutes = standupTime.split(':')[1]
    try
      standupHours = parseInt(standupHours, 10)
      standupMinutes = parseInt(standupMinutes, 10)
    catch _error
      return false
    if standupHours == currentHours and standupMinutes == currentMinutes
      return true
    false

  # Returns all standups.
  getStandups = ->
    standups = []
    mobileRoom = {
      time: '15:35'
      room: '56a11fb226167219f84c4252@conference.example.com'
    }
    mobileRoom2 = {
      time: '16:31'
      room: '56a11fb226167219f84c4252@conference.example.com'
    }
    standups.push mobileRoom, mobileRoom2
    return standups

  # Returns just standups for a given room.
  getStandupsForRoom = (room) ->
    _.where getStandups(), room: room

  # Gets all standups, fires ones that should be.
  checkStandups = ->
    standups = getStandups()
    _.chain(standups).filter(standupShouldFire).pluck('room').each doStandup

  # Fires the standup message.
  doStandup = (room) ->
    message = PREPEND_MESSAGE + _.sample(STANDUP_MESSAGES)
    robot.messageRoom room, message
    robot.messageRoom room, "...and here's the link: https://confluence.inin.com/display/CLOUD/StatusReport?run_param_status_date=#{moment().add(2, 'days').format('MM-DD-YYYY')}"

  # Finds the room for most adaptors
  findRoom = (msg) ->
    room = msg.envelope.room
    if _.isUndefined(room)
      room = msg.envelope.user.reply_to
    room

  # Stores a standup in the brain.
  saveStandup = (room, time, utc) ->
    standups = getStandups()
    newStandup =
      time: time
      room: room
      utc: utc
    standups.push newStandup
    updateBrain standups
    return

  # Updates the brain's standup knowledge.
  updateBrain = (standups) ->
    robot.brain.set 'standups', standups
    return

  clearAllStandupsForRoom = (room) ->
    standups = getStandups()
    standupsToKeep = _.reject(standups, room: room)
    updateBrain standupsToKeep
    standups.length - (standupsToKeep.length)

  clearSpecificStandupForRoom = (room, time) ->
    standups = getStandups()
    standupsToKeep = _.reject(standups,
      room: room
      time: time)
    updateBrain standupsToKeep
    standups.length - (standupsToKeep.length)

# https://confluence.inin.com/display/CLOUD/StatusReport?run_param_status_date=#{moment().add(2, 'days').format('MM-DD-YYYY')}

  'use strict'
  # Constants.
  STANDUP_MESSAGES = [
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://2.bp.blogspot.com/--whak8S6_A4/Vo5AcSR-stI/AAAAAAAAA9Y/ru7al_b4S18/s1600/100-Good-Status-for-Whatsapp-About-Life-in-English-01.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://1.bp.blogspot.com/-bc06uo9r40s/Vn4TAmxHN2I/AAAAAAAACw4/NHxBER7c2V8/s1600/Alone-Status-Whatsapp.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://cdn.diypros.in/m132/wp-content/uploads/2016/03/quote-best-motivational-quotes-photos-hd-hq-for-1016830.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://cdn3.geckoandfly.com/wp-content/uploads/2014/03/motivation-motivational-quotes-poster-wallpaper7.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://exercise-workouts.org/wp-content/uploads/2014/08/Inspirational-Fitness-Quotes.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://www.jamesvincent.life/wp-content/uploads/2015/05/motivational_quotes_inspirational_winston_churchill.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://antiquesearch.net/wp-content/uploads/2016/05/business-motivational-quotes-flt5tgyd.png"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://antiquesearch.net/wp-content/uploads/2016/05/business-motivational-quotes-eugz5pip.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://addicted2success.com/wp-content/uploads/2012/04/Motivational-Gym-Success-Wallpapers-Quotes-Picture-Quotes.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://motivationquote.co/wp-content/uploads/2016/03/success-motivational-quotes-of-the-day-1.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://www.quoteslike.com/images/475/inspirational-quotes-about-success-in-school-image-gallery-OjQLaf-quote.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://motivationquote.co/wp-content/uploads/2016/03/success-motivational-quotes-sports.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://cdn4.geckoandfly.com/wp-content/uploads/2014/08/quotes-inspire-success2.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://antiquesearch.net/wp-content/uploads/2016/04/best-success-motivational-quotes-tucasb3u.png"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://cdn3.geckoandfly.com/wp-content/uploads/2014/08/quotes-inspire-success4.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttps://crystalhealinghands.files.wordpress.com/2014/12/possitive-quote-it-doesnt-matter-if-anyone.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://cdn.geckoandfly.com/wp-content/uploads/2014/08/inspirational-smll-business-quotes11.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttps://www.motivationalpicturequotes.com/wp-content/uploads/457/motivational-quotes.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttp://www.indiaonrent.com/forwards/m/motivational-wallpapers/res/r2qfj0.jpg"
    "## STATUS REPORT\n### This is your friendly reminder to stay positive and submit your status report:\nhttps://s-media-cache-ak0.pinimg.com/736x/cb/c7/34/cbc734cf0ebc2d39f74e5fc25150d434.jpg"
  ]
  PREPEND_MESSAGE = process.env.HUBOT_STANDUP_PREPEND or ''
  if PREPEND_MESSAGE.length > 0 and PREPEND_MESSAGE.slice(-1) != ' '
    PREPEND_MESSAGE += ' '

  # Check for standups that need to be fired, once a minute
  # Monday to Friday.
  new cronJob('1 * * * * 5', checkStandups, null, true)
