pkg = require "../../../../../package.json"

###*
 * This class provides other classes with a way to
 * interact with the back-end API.
###
class API

	constructor: ->

		# Determine the environment
		@env = if window.location.host.indexOf("localhost") is -1 then "production" else "development"

	###*
	 * Get the URL for the required API
	 * @param  {string} endpoint the name of the required API
	 * @return {string}          the URL of the required API
	###
	getURL: (endpoint) ->

		if @env is "development"
			return "http://localhost:8000/api/" + pkg.version + "/" + endpoint

		if @env is "production"
			return pkg.homepage + "/api/" + pkg.version + "/" + endpoint


module.exports = new API