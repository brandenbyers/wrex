# Description:
#   @mention the mobile team
#
# Commands:
#   @mobile - Reply with @mention of everyone in the mobile team
#   taylor swift|swifty|tails|tayter tot|taytay|t-swift|t-swizzle|tay - Reply with Taylor Swift

module.exports = (robot) ->

  mention = (user, message) ->
    # TODO: Purecloud adapter needs updating to return actual user instead of group
    # nameWithDot = user.match(/(.+)@inin.com/i)[1]
    # name = nameWithDot.split('.').join(' ')
    # nameCap = name.replace(/(^|\s)[a-z]/g, (f) -> f.toUpperCase())

    str = """
          > ###### [@Your Mobile Team Member](#/person/abcdefghijklmnopqrstuv) said
          > #{message}

          [   ](#/person/53a2ecf39cfde35e232982a9) [   ](#/person/50c26f9b3711784291c6807a) [   ](#/person/54f07909d96de71e0a552740) [   ](#/person/53a2eceb9cfde35e2329822a) [   ](#/person/53a2ed209cfde35e23298300) [   ](#/person/53a2ed4a9cfde35e23298437) [   ](#/person/50c26fa43711784290c68026) [   ](#/person/561fcf4e3e0d3317a49d846f) [   ](#/person/5361a63e64a211297b74a391) [   ](#/person/53a2ecec9cfde35e23298236) [   ](#/person/53a2ed3e9cfde35e2329840e)
          Yo mobile team! This is important!
          """

    return str

  robot.hear /@mobile/i, (msg) ->
    console.log 'msg', msg
    console.log 'msg.message.text', msg.message.text
    console.log 'msg.message.user.name', msg.message.user.name
    console.log 'msg.message.user', msg.message.user
    msg.send mention(msg.message.user.name, msg.message.text)

