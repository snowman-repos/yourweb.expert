jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Full Height Section", ->

	FullHeightSections = require "./full-height-section.coffee"

	beforeEach ->
		loadFixtures "home-page.html"

		FullHeightSections.sections = []
		for section in document.querySelectorAll ".js-full-height-section"
			FullHeightSections.sections.push
				content: section.querySelector ".js-full-height-section__content"
				el: section

		if FullHeightSections.sections.length
			FullHeightSections.addEventListeners()

	it "should get the minimum height of each section", ->

		for section in FullHeightSections.sections

			contentHeight = section.content.offsetHeight
			minHeight = FullHeightSections.getMinimumHeight section

			if section.el.classList.contains "o-section--padding-top"
				expect(minHeight).toEqual contentHeight + 100
			else
				expect(minHeight).toEqual contentHeight

	it "should remove the full-height class when necessary", ->

		for section in FullHeightSections.sections

			minHeight = FullHeightSections.getMinimumHeight section

			if section.el.classList.contains "o-section--full-height"

				# First make sure the window is taller than the section
				window.resizeTo minHeight * 2, minHeight * 2
				expect(section.el.classList).toContain "o-section--full-height"

				# Then check once the window is shorter than the section
				window.resizeTo minHeight * 0.5, minHeight * 0.5
				expect(section.el.classList).not.toContain "o-section--full-height"

	it "should update all sections", ->

		spyOn FullHeightSections, "updateSection"
		FullHeightSections.updateAllSections()
		expect(FullHeightSections.updateSection.calls.count()).toEqual FullHeightSections.sections.length