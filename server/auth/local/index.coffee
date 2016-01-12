"use strict"

express = require "express"
passport = require "passport"
auth = require "../auth.service"

router = express.Router()

router.post "/", (req, res, next) ->
	passport.authenticate("local", (err, user, info) ->
		error = err || info
		if error then return res.status(401).jsonp error
		if !user then return res.status(404).jsonp message: "Something went wrong, please try again."

		token = auth.signToken user._id, user.role
		res.jsonp
			token: token
			id: user._id
	)(req, res, next)

module.exports = router