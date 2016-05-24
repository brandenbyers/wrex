# Description:
#   Summon Taylor Swift
#
# Commands:
#   hubot tay me - Reply with Taylor Swift
#   taylor swift|swifty|tails|tayter tot|taytay|t-swift|t-swizzle|tay - Reply with Taylor Swift

tay = [
	"https://media0.giphy.com/media/l0K4c8bZHJzDCmg6Y/200.gif",
	"https://media2.giphy.com/media/3o7qDPw0ut34r5Tala/200.gif",
	"https://media0.giphy.com/media/g8CJl0epg71MQ/200.gif",
	"https://media2.giphy.com/media/rvDtLCABDMaqY/200.gif",
	"https://media3.giphy.com/media/HDQO74ekA0Hp6/200.gif",
	"https://media1.giphy.com/media/3oEduYNRQXNYfGZ7LG/200.gif",
	"https://media1.giphy.com/media/qvWCTAG5MxOmc/200.gif",
	"https://media1.giphy.com/media/KDHkHNpM3Eht6/200.gif",
	"https://media0.giphy.com/media/vk8zbMJQcfaIE/200.gif",
	"https://media.giphy.com/media/nXiel1G5ToSgU/giphy.gif",
	"http://media1.giphy.com/media/nXOds9I8K8gUg/giphy.gif",
	"https://media.giphy.com/media/RMonqmwIZagbm/giphy.gif",
	"http://www.reactiongifs.com/r/tw.gif",
	"http://www.reactiongifs.com/r/tssmd.gif",
	"http://www.reactiongifs.com/wp-content/uploads/2013/09/thug.gif",
	"http://www.reactiongifs.com/wp-content/uploads/2013/10/taylor-swift-mind-blown.gif",
	"http://cdn.playbuzz.com/cdn/d6edbba5-ddfb-4438-8b5d-17458f98ab88/30b228c6-db5d-4105-aa38-bbe0533f3cc5.gif",
	"https://66.media.tumblr.com/5e0096d02ca16c3382c1006e9f6c338d/tumblr_neabpn72Cw1tm4tz8o1_400.gif",
	"https://media.giphy.com/media/895uU9amktvgc/giphy.gif",
	"http://danglingmouse.com/wp-content/uploads/2014/10/taylor-laughing.gif",
	"http://ak-hdl.buzzfed.com/static/2015-04/13/0/imagebuzz/webdr01/anigif_optimized-17556-1428901157-16.gif",
	"http://likegif.com/wp-content/uploads/2013/03/Taylor-Swift-gif-114.gif",
	"http://static.buzznet.com/uploads/2016/03/unnamed10.gif",
	"http://2.bp.blogspot.com/-CqCYGJUibOM/VVsn0WPVzzI/AAAAAAAAHek/AGefXk0S8kI/s1600/Taylor-swift-Bad-Blood-Neve.gif",
	"https://media.giphy.com/media/26BkLBA32cX3AfM0o/giphy.gif",
	"http://www.eonline.com/eol_images/Entire_Site/20141010//rs_540x225-141110045936-tumblr_neti2yNK1i1tarer7o1_1280.gif",
]

module.exports = (robot) ->
	
	robot.respond /tay me/i, (msg) ->
		msg.send msg.random tay
		
	tayExpression = /\b(taylor swift|swifty|tails|tayter tot|taytay|t-swift|t-swizzle|tay)\b/i
			
	robot.hear tayExpression, (msg) ->
		msg.send msg.random tay
