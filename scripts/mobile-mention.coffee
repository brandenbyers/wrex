# Description:
#   @mention the mobile team
#
# Commands:
#   @mobile - Reply with @mention of everyone in the mobile team
#   taylor swift|swifty|tails|tayter tot|taytay|t-swift|t-swizzle|tay - Reply with Taylor Swift

module.exports = (robot) ->

  mention = (user, message) ->
    nameWithDot = user.match(/(.+)@inin.com/i)[1]
    name = nameWithDot.split('.').join(' ')
    nameCap = name.replace(/(^|\s)[a-z]/g, (f) -> f.toUpperCase())

    str = "> ###### [@#{nameCap}](#/person/abcdefghijklmnopqrstuv) said
          > #{message}

          [](#/person/57350c17a6a8301c3de8b941) [](#/person/54f07909d96de71e0a552740)
          Yo mobile team! #{nameCap} said something that you all should read."

    return str

  robot.hear /@mobile/i, (msg) ->
    msg.send mention(msg.message.user.name, msg.message.text)
