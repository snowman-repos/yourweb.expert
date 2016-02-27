jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Map", ->

	Map = require "./map.coffee"

	beforeEach ->

		window.ga = ->

		loadFixtures "home-page.html"
		Map.el.map = document.querySelector ".js-map"

	it "should toggle the zoom state of the map", ->

		Map.el.map.classList.remove "is-zoomed"

		Map.toggleZoomState()

		setTimeout ->

			expect(Map.el.map.classList).toContain "is-zoomed"

			Map.toggleZoomState()

			setTimeout ->

				expect(Map.el.map.classList).not.toContain "is-zoomed"

			, Map.config.delay

		, Map.config.delay

	it "should zoom the map out", ->

		Map.zoom()

		setTimeout ->

			expect(Map.el.map.classList).toContain "is-zoomed"

		, Map.config.delay