clients = require "../clients/clients.coffee"
map = require "../map/map.coffee"
services = require "../services/services.coffee"

###*
 * This class simply handles the running of functions
 * when the user scrolls to sections that require
 * such functions to be run only when they come into
 * view. As these functions exist in different classes,
 * this class exists to keep track of them.
###
class Waypoints

	constructor: ->

	###*
	 * Run a function
	 * @param  {String} f A reference to a function to be run
	###
	run: (f) ->

		switch f
			when "check-checkmarks" then services.checkCheckmarks()
			when "show-logos" then clients.showLogos()
			when "zoom-in-map" then map.zoom()


module.exports = new Waypoints