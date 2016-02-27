jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Morph Button", ->

	MorphButton = require "./morph-button.coffee"

	beforeEach ->

		window.ga = ->

		loadFixtures "home-page.html"

		morphButtons = document.querySelectorAll ".js-morph-button"

		MorphButton.components = []
		for button in morphButtons
			MorphButton.components.push
				closeButton: button.querySelector ".js-morph-button-close"
				element: button
				openButton: button.querySelector ".js-morph-button-open"

	it "should morph from button to dialog", ->

		for component in MorphButton.components

			expect(component.element.classList).not.toContain "is-open"
			MorphButton.openMorphButton component
			expect(component.element.classList).toContain "is-open"

	it "should morph from dialog to button", ->

		for component in MorphButton.components
			MorphButton.openMorphButton component
			expect(component.element.classList).toContain "is-open"
			MorphButton.closeMorphButton component
			expect(component.element.classList).not.toContain "is-open"

	it "should show the morph button components", ->

		for component in MorphButton.components

			expect(component.element.classList).toContain "is-hidden"

		MorphButton.showMorphButtons()

		setTimeout ->

			for component in MorphButton.components
				expect(component.element.classList).not.toContain "is-hidden"

		, MorphButton.config.delay