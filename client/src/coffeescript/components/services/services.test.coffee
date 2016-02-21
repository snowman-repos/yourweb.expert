jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Services", ->

	Services = require "./services.coffee"

	beforeEach ->
		loadFixtures "home-page.html"

		Services.checkmarks = Array.prototype.slice.call document.querySelectorAll ".js-checkmark"

	it "should check checkmarks", ->

		for checkmark in Services.checkmarks

			expect(checkmark.classList).not.toContain "is-checked"

		Services.checkCheckmarks()

		setTimeout ->

			for checkmark in Services.checkmarks
				expect(checkmark.classList).toContain "is-checked"

		, Services.config.delay