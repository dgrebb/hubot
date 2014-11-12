# Description:
#   "Accepts POST data and broadcasts it"
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLs:
#   POST /hubot/say
#     message = <message>
#     channel = <channel>
#     type = <type>
#
#   curl -X POST http://localhost:8080/hubot/say -d message=lala -d channel='#dev'
#
# Author:
#   insom
#   luxflux

module.exports = (robot) ->
  robot.router.post "/hubot/say", (req, res) ->
    body = req.body
    channel = body.channel
    message = body.message

    robot.logger.info "Message '#{message}' received for channel #{channel}"

    if message
      robot.messageRoom channel, message

    res.writeHead 200, {'Content-Type': 'text/plain'}
    res.end 'Thanks\n'