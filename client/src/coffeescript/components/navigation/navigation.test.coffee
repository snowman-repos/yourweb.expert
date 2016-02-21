jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Navigation", ->

	Navigation = require "./navigation.coffee"
	scrollPoints = []

	beforeEach ->
		loadFixtures "home-page.html"

		Navigation.el.menu = document.querySelector ".js-navigation-menu"
		Navigation.links = {}

		scrollPoints = document.querySelectorAll ".js-scroll-point"

	it "should activate a single navigation menu item link", ->

		for scrollPoint in scrollPoints
			Navigation.addItem scrollPoint

		for scrollPoint in scrollPoints
			expect(Navigation.links[scrollPoint.id].classList).not.toContain "is-active"
			Navigation.activateItem scrollPoint
			expect(Navigation.links[scrollPoint.id].classList).toContain "is-active"

	it "should add a navigation item", ->

		expect(Navigation.el.menu.innerHTML).toBe ""

		Navigation.addItem(scrollPoints[0])

		expect(Navigation.el.menu.innerHTML).not.toBe ""

	it "should generate a list item", ->

		ID = scrollPoints[0].id
		navTitle = scrollPoints[0].dataset.navTitle

		expected = '<li class="o-navigation__menu__item"><a href="#' + ID + '" title="' + navTitle + '" class="o-navigation__menu__item__link"></a></li>'

		item = Navigation.generateListItem(scrollPoints[0])
		tmp = document.createElement "div"
		tmp.appendChild item
		result = tmp.innerHTML

		expect(result).toMatch expected

	it "should reset all navigation items", ->

		for scrollPoint in scrollPoints
			Navigation.addItem scrollPoint
			Navigation.activateItem scrollPoint
			expect(Navigation.links[scrollPoint.id].classList).toContain "is-active"

		Navigation.resetItems()

		for scrollPoint in scrollPoints

			expect(Navigation.links[scrollPoint.id].classList).not.toContain "is-active"