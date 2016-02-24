"use strict"

config = require "../../config/environment"
feed = require "feed-read"
request = require "request"

exports.index = (req, res) ->

	feed "https://medium.com/feed/@darryl.snow", (error, articles) ->

		if !error

			res.jsonp articles

		else

			throw err

