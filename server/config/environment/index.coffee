"use strict"

path = require "path"
_ = require "lodash"

requiredProcessEnv = (name) ->
	if !process.env[name]
		throw new Error "You must set the " + name + " environment variable"
	process.env[name]

# All configurations will extend these options
all =
	env: process.env.NODE_ENV
	# Root path of server
	root: path.normalize __dirname + "/../../.."
	# Server port
	port: process.env.PORT || 8000
	# Should we populate the DB with sample data?
	seedDB: true
	# Secret for session, you will want to change this and make it an environment variable
	secrets:
		session: process.env.SESSION_SECRET
	# List of user roles
	userRoles: ["guest", "user", "admin"]
	# MongoDB connection options
	mongo:
		options:
			db:
				safe: true
	blog:
		clientID:     process.env.TUMBLR_ID || "id",
		clientSecret: process.env.TUMBLR_SECRET || "secret",
		callbackURL:  "http://localhost:9000/auth/tumblr/callback"
	currency:
		clientID:     process.env.OPENEXCHANGE_ID || "id"
	mailgun:
		domain:       process.env.MAILGUN_DOMAIN || "domain"
		key:          process.env.MAILGUN_KEY || "key"
	weatheronline:
		clientID:     process.env.WEATHERONLINE_ID || "id"

# Export the config object based on the NODE_ENV
module.exports = _.merge(
	all,
	require "./" + process.env.NODE_ENV + ".coffee" || {})