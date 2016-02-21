jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Map", ->

	Map = require "./map.coffee"

	beforeEach ->
		loadFixtures "home-page.html"
		Map.el.map = document.querySelector ".js-map"

	it "should zoom the map out", ->

		Map.zoom()

		setTimeout ->

			expect(Map.el.map.classList).toContain "is-zoomed"

		, Map.config.delay