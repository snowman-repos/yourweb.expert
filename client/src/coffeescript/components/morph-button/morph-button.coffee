###*
 * This class provides the functionality for
 * a button that transitions into a modal dialog
 * when clicked.
###
class MorphButton

	constructor: ->

		# Gather all the morph button components
		morphButtons = document.querySelectorAll ".js-morph-button"

		@components = []
		for button in morphButtons
			@components.push
				closeButton: button.querySelector ".js-morph-button-close"
				element: button
				openButton: button.querySelector ".js-morph-button-open"

		@config =
			delay: 1000

		# No need to add event listeners and show
		# the morph buttons if there aren't any...
		if @components.length
			@addEventListeners()
			@showMorphButtons()

	###*
	 * Attach event listeners to the open and close
	 * buttons of each component.
	###
	addEventListeners: ->

		for component in @components

			component.openButton.addEventListener "click", (e) =>
				component.element.classList.add "is-open"

			component.closeButton.addEventListener "click", (e) =>
				component.element.classList.remove "is-open"

	###*
	 * Display the morph buttons via a CSS fade-in.
	###
	showMorphButtons: ->

		# Allow for a short delay in order to highlight
		# the morph button
		setTimeout =>

			for component in @components
				component.element.classList.remove "is-hidden"

		, @config.delay


module.exports = new MorphButton