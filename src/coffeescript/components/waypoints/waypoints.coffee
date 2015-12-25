clients = require "../clients/clients.coffee"
services = require "../services/services.coffee"

class Waypoints

	constructor: ->

	run: (f) ->
		
		switch f
			when "check-checkmarks" then services.checkCheckmarks()
			when "show-logos" then clients.showLogos()


module.exports = new Waypoints