###*
 * This class provides a function to zoom in on the map.
###
class Map

	constructor: ->

		@el =
			map: document.querySelector ".js-map"

		@config =
			delay: 2000

	###*
	 * Zoom in on the map
	###
	zoom: ->

		if @el.map

			# set a short delay to allow the user to
			# recognise the map of China before zooming
			setTimeout =>

				@el.map.classList.add "is-zoomed"

			, @config.delay


module.exports = new Map