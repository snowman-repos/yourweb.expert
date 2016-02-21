jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Scroll Watcher", ->

	ScrollWatcher = require "./scroll-watcher.coffee"
	Waypoints = require "../waypoints/waypoints.coffee"

	beforeEach ->
		loadFixtures "home-page.html"

		ScrollWatcher.el.scrollPoints = document.querySelectorAll ".js-scroll-point"

		spyOn Waypoints, "run"

	it "should be able to run the 'when in view' function", ->

		for scrollPoint in ScrollWatcher.el.scrollPoints

			inViewFunction = scrollPoint.dataset.whenInView

			if inViewFunction

				ScrollWatcher.runInViewFunction scrollPoint
				expect(Waypoints.run).toHaveBeenCalled()