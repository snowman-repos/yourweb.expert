"use strict"

express			= require "express"
favicon			= require "static-favicon"
morgan			= require "morgan"
compression		= require "compression"
bodyParser		= require "body-parser"
methodOverride	= require "method-override"
# minifyHTML		= require "express-minify-html"
cookieParser	= require "cookie-parser"
errorHandler	= require "errorhandler"
path			= require "path"
config			= require "./environment"
passport		= require "passport"
session			= require "express-session"
mongoStore		= require("connect-mongo")(session)

module.exports = (app) ->
	env = app.get "env"

	app.use compression()
	app.use bodyParser.urlencoded
		extended: true
	app.use bodyParser.json()
	app.use methodOverride()
	app.use cookieParser()
	app.use passport.initialize()
	app.use express.static __dirname + "/../../client/public"

	# app.use minifyHTML
	# 	override: true
	# 	displayErrors: process.env.NODE_ENV == "development"
	# 	htmlMinifier:
	# 		removeComments: true
	# 		collapseWhitespace: true
	# 		collapseBooleanAttributes: true
	# 		removeEmptyAttributes: true
	# 		minifyJS: true

	# # Persist sessions with mongoStore
	# app.use session
	# 	resave: true
	# 	saveUninitialized: true
	# 	secret: config.secrets.session
	# 	store: new mongoStore
	# 		url: config.mongo.uri
	# 		collection: "sessions"
	# 	, ->
	# 		console.log("db connection open")