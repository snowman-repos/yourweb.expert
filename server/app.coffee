"use strict"

process.env.NODE_ENV = process.env.NODE_ENV || "development"

if process.env.NODE_ENV is "development"
	localenv = require "./config/local.env"
	process.env.MAILGUN_DOMAIN = localenv.MAILGUN_DOMAIN
	process.env.MAILGUN_KEY = localenv.MAILGUN_KEY
	process.env.MEDIUM_ID = localenv.MEDIUM_ID
	process.env.MEDIUM_SECRET = localenv.MEDIUM_SECRET
	process.env.OPENEXCHANGE_ID = localenv.OPENEXCHANGE_ID
	process.env.SESSION_SECRET = localenv.SESSION_SECRET
	process.env.TUMBLR_ID = localenv.TUMBLR_ID
	process.env.TUMBLR_SECRET = localenv.TUMBLR_SECRET
	process.env.WEATHERONLINE_ID = localenv.WEATHERONLINE_ID

express = require "express"
mongoose = require "mongoose"
config = require "./config/environment"

# Connect to database
mongoose.connect config.mongo.uri, config.mongo.options

# Populate DB with sample data
# if config.seedDB
# 	require "./config/seed"

# Setup server
app = express()
server = require("http").createServer app
require("./config/express")(app)
require("./routes")(app)

# Start server
server.listen config.port, config.ip, ->
	console.log "Express server listening on %d, in %s mode", config.port, app.get "env"

# Expose app
exports = module.exports = app