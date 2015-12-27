clients = require "../clients/clients.coffee"
map = require "../map/map.coffee"
services = require "../services/services.coffee"

class Waypoints

	constructor: ->

	run: (f) ->
		
		switch f
			when "check-checkmarks" then services.checkCheckmarks()
			when "show-logos" then clients.showLogos()
			when "zoom-in-map" then map.zoom()


module.exports = new Waypoints