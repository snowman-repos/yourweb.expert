"use strict"

config = require "../../config/environment"
request = require "request"

exports.index = (req, res) ->
	
	request "http://api.tumblr.com/v2/blog/darryl-snow.tumblr.com/posts?type=text&limit=1&api_key=" + config.blog.clientID, (error, response, body) ->
		if !error and response.statusCode is 200
			blogData = JSON.parse body
			blog =
				title: blogData.response.posts[0].title
				body: blogData.response.posts[0].body
				date: blogData.response.posts[0].date
				url: blogData.response.posts[0].post_url
			res.jsonp blog