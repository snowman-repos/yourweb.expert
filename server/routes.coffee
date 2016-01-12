"use strict"

module.exports = (app) ->

	apiPath = "/api"
	version = "/" + (require "../package.json").version

	app.use (req, res, next) ->
		res.header "Access-Control-Allow-Origin", "*"
		res.header "Access-Control-Allow-Headers", "Authorization, Origin, X-Requested-With, Content-Type, Accept"
		res.header "Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS"
		next()

	app.use apiPath + version + "/currency", require ("./api/currency")
	app.use apiPath + version + "/blog", require ("./api/blog")
	app.use apiPath + version + "/weather", require ("./api/weather")

	app.use "/auth", require ("./auth")

	# All undefined asset or API routes should return a 404

	app.route "/:url(api|auth)/*", (req, res) ->
		res.status 404