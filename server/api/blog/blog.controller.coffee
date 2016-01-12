"use strict"

config = require "../../config/environment"
request = require "request"

exports.index = (req, res) ->

	request "http://api.tumblr.com/v2/blog/darryl-snow.tumblr.com/posts?type=text&limit=5&api_key=" + config.blog.clientID, (error, response, body) ->
		if !error and response.statusCode is 200
			blogData = JSON.parse body
			res.jsonp blogData.response.posts