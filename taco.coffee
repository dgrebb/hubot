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
#   hubot taco me - Pulls a recipe from taco randomizer
#
# Author:
#   dgrebb

scraper = require('scraper')

module.exports = (robot) ->
    robot.respond /(taco me)(.*)/i, (message) ->a
        search = message.match[2]
        
        options = {
            'uri': "http://taco-randomizer.herokuapp.com",
            'headers': {
                'Accept-Language': 'en-us,en;q=0.5',
                'Accept-Charset': 'utf-8',
                'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17'
            }
        }

        scraper options, (err, jQuery) ->
            message.send err  if err
            if jQuery('*:contains("did not match any documents.")').length > 0
                message.send "Sorry, I can't find any tacos right now.\n"
            else
                # message.send options.uri
                scraper options, (err, jQuery) ->
                    message.send err  if err
                    taco = jQuery("#taco-content h1:first")
                    link = jQuery("#taco-content h5:eq(1) a").attr('href')
                    result = jQuery(taco).text()

                    message.send result
                    message.send options.uri+link