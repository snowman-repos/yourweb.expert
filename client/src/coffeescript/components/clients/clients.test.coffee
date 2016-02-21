jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Clients", ->

	Clients = require "./clients.coffee"

	beforeEach ->
		loadFixtures "home-page.html"
		Clients.logos = Array.prototype.slice.call document.querySelectorAll ".js-client-logo"

	it "should show logos sequentially", ->

		for logo in Clients.logos

			expect(logo.classList).not.toContain "is-shown"

		Clients.showLogos()

		setTimeout ->

			for logo in Clients.logos

				expect(logo.classList).toContain "is-shown"

		, (Clients.config.delay * Clients.logos.length) + 100