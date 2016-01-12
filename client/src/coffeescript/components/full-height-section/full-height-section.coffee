_ = require "lodash"

class FullHeightSection

	constructor: (el) ->

		@el =
			content: el.querySelector ".o-section__content__container"
			section: el

		window.addEventListener "load", =>
			@determineHeight()

		window.addEventListener "resize", _.debounce =>
			@determineHeight()
		, 500

	determineHeight: ->

		if @el.section.classList.contains "o-section--padding-top"
			contentHeight = @el.content.offsetHeight + 100
		else
			contentHeight = @el.content.offsetHeight

		if contentHeight < window.innerHeight
			@el.section.classList.add "o-section--full-height"
		else
			@el.section.classList.remove "o-section--full-height"


module.exports = do ->

	fullHeightSections = document.querySelectorAll ".js-full-height-section"

	for section in fullHeightSections
		new FullHeightSection section