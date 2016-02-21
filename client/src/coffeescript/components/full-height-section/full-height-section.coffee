_ = require "lodash/function/debounce"

###*
 * Class to make some sections full-height, i.e.
 * equal height compared to the viewport. This
 * style should only be applied if the height of
 * the content inside the section is smaller than
 * the viewport height. The heights of such sections
 * may need to be updated if the browser window is
 * resized.
###
class FullHeightSections

	constructor: ->

		# Gather all required section and section
		# content elements in an array.
		@sections = []
		for section in document.querySelectorAll ".js-full-height-section"
			@sections.push
				content: section.querySelector ".js-full-height-section__content"
				el: section

		# Only add event listeners if necessary.
		if @sections.length
			@addEventListeners()

	###*
	 * Update sections when the page is first loaded
 	 * and whenever the window is resized.
	###
	addEventListeners: ->

		window.addEventListener "load", =>
			@updateAllSections()

		window.addEventListener "resize", _ =>
			console.log "resized!"
			@updateAllSections()
		, 500

	###*
	 * Determine the minimum height of the section,
	 * based on the height of the section's content.
	 * @param  {Object}  section An object referencing the section in question and its content
	 * @return {Integer}         The minimum height of the section.
	###
	getMinimumHeight: (section) ->

		extra = 0

		if section.el.classList.contains "o-section--padding-top"
			extra = 100

		section.content.offsetHeight + extra

	###
	Make a section full height only if the height
	of the content doesn't exceed the window height.
	(i.e. prevent content from ever being cut off)
	@section - the section in question
	@height - the height of the section content
	###
	updateSection: (section, minHeight) ->

		if minHeight < window.innerHeight
			section.el.classList.add "o-section--full-height"
		else
			section.el.classList.remove "o-section--full-height"

	###*
	 * Go through each required section and apply
 	 * the correct CSS classes.
	###
	updateAllSections: ->

		for section in @sections
			if section.content
				minHeight = @getMinimumHeight section
				@updateSection section, minHeight


module.exports = new FullHeightSections