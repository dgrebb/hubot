# Description:
#   Tacos
#
# Dependencies:
#   "scraper": "0.0.9"
#
# Configuration:
#   None
#
# Commands:
#   hubot pizza me - Pulls a random pizza gif from pizzagifs.tumblr.com
#
# Author:
#   dgrebb

scraper = require('scraper')

module.exports = (robot) ->
    robot.respond /(pizza me)(.*)/i, (message) ->
        search = message.match[2]
        
        options = {
            'uri': "http://pizzagifs.tumblr.com/random",
            'headers': {
                'Accept-Language': 'en-us,en;q=0.5',
                'Accept-Charset': 'utf-8',
                'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17'
            }
        }

        scraper options, (err, jQuery) ->
            message.send err  if err
            if jQuery('*:contains("did not match any documents.")').length > 0
                message.send "Sorry, I can't find any pizza right now.\n"
            else
                # message.send options.uri
                scraper options, (err, jQuery) ->
                    message.send err  if err
                    pizza = jQuery("div.media a img").attr('src')

                    message.send pizza
