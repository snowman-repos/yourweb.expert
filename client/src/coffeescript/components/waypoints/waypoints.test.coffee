jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Waypoints", ->

	Clients = require "../clients/clients.coffee"
	Map = require "../map/map.coffee"
	Services = require "../services/services.coffee"
	Waypoints = require "./waypoints.coffee"

	beforeEach ->
		loadFixtures "home-page.html"

		Clients.logos = Array.prototype.slice.call document.querySelectorAll ".js-client-logo"

		spyOn Clients, "showLogos"
		spyOn Map, "zoom"
		spyOn Services, "checkCheckmarks"

	it "should run the specified functions", ->

		Waypoints.run "check-checkmarks"
		Waypoints.run "show-logos"
		Waypoints.run "zoom-in-map"

		expect(Clients.showLogos).toHaveBeenCalled()
		expect(Map.zoom).toHaveBeenCalled()
		expect(Services.checkCheckmarks).toHaveBeenCalled()