"use strict"

express = require "express"
oauth = require "oauth"
auth = require "../auth.service"
config = require "../../config/environment"
Blog = require "../../api/blog/blog.model"

router = express.Router()

oauthRequestToken = undefined
oauthRequestTokenSecret = undefined

consumer = new oauth.OAuth(
	"http://www.blog.com/oauth/request_token",
	"http://www.blog.com/oauth/access_token",
	config.blog.clientID,
	config.blog.clientSecret,
	"1.0A",
	"http://localhost:9000/auth/blog/callback",
	"HMAC-SHA1"
)

router
	.get "/", (req, res) ->
		consumer.getOAuthRequestToken (err, oauthToken, oauthTokenSecret) ->
			if err
				res.send "Error getting Blog OAuth request token: " + err, 500
			else
				oauthRequestToken = oauthToken
				oauthRequestTokenSecret = oauthTokenSecret
				res.redirect "http://www.blog.com/oauth/authorize?oauth_token=" + oauthRequestToken

	.get "/callback", (req, res) ->
		consumer.getOAuthAccessToken oauthRequestToken, oauthRequestTokenSecret, req.query.oauth_verifier, (error, _oauthAccessToken, _oauthAccessTokenSecret) ->
			if error
				res.send "Error getting OAuth access token: " + error, 500
			else
				Blog.find({}).remove ->
					Blog.create
						accessToken: _oauthAccessToken,
						accessTokenSecret: _oauthAccessTokenSecret
				res.redirect "/api/blog"

module.exports = router