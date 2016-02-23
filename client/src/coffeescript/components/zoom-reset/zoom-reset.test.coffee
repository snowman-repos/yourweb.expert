jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Zoom Reset", ->

	ZoomReset = require "../zoom-reset/zoom-reset.coffee"

	beforeEach ->
		loadFixtures "home-page.html"

		ZoomReset.el.inputs = document.querySelectorAll "input, select, textarea"
		ZoomReset.el.metaTag = document.querySelector "meta[name=viewport]"