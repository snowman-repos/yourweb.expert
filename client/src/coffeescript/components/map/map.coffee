class Map

	constructor: ->

		@el =
			map: document.querySelector ".js-map"

	zoom: ->

		if @el.map

			# set a short delay to allow the user to
			# recognise the map of China before zooming
			setTimeout =>

				@el.map.classList.add "is-zoomed"

			, 2000

module.exports = new Map