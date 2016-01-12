pkg = require "../../../../../package.json"

class API

	constructor: ->

		@env = if window.location.host.indexOf("localhost") is -1 then "production" else "development"

	getURL: ->

		if @env is "development"
			return "http://localhost:8000/api/" + pkg.version

		if @env is "production"
			return pkg.homepage + "/api/" + pkg.version


module.exports = new API