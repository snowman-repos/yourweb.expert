###*
 * This class provides a function to zoom in on the map.
###
class Map

	constructor: ->

		@el =
			map: document.querySelector ".js-map"

		@config =
			delay: 2000

		@addEventListeners()

	###*
	 * Listen to when the map is clicked.
	###
	addEventListeners: ->

		if @el.map

			@el.map.addEventListener "click", (e) =>

				@toggleZoomState()

			, true

	###*
	 * Toggle the zoom state of the map.
	###
	toggleZoomState: ->

		if @el.map.classList.contains "is-zoomed"
			@el.map.classList.remove "is-zoomed"
			ga "send", "event", "map", "zoom", "zoom out"
		else
			@el.map.classList.add "is-zoomed"
			ga "send", "event", "map", "zoom", "zoom in"
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