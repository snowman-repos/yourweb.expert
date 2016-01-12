passport = require "passport"
LocalStrategy = require("passport-local").Strategy

exports.setup = (User, config) ->
	passport.use new LocalStrategy
			usernameField: "email"
			passwordField: "password"
		, (email, password, done) ->
			User.findOne
				email: email.toLowerCase()
			, (err, user) ->
				if err then return done err
				if !user then return done null, false, message: "This email is not registered."
				if !user.authenticate(password) then return done null, false, message: "This password is not correct."
				return done null, user