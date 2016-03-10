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
				e.preventDefault()
				@openMorphButton e.target.parentNode
				ga "send", "event", "morph button", "click", "open", e.target.parentNode,
					nonInteraction: 1

			component.closeButton.addEventListener "click", (e) =>
				@closeMorphButton e.target.parentNode.parentNode.parentNode
				ga "send", "event", "morph button", "click", "close", e.target.parentNode.parentNode.parentNode,
					nonInteraction: 1

	###*
	 * Opens the morph button, i.e.
	 * button -> dialog
	 * @param  {Object} element   The DOM node for the morph button component
	 * @return {Object}           The DOM node for the morph button component
	###
	openMorphButton: (element) ->

		element.classList.add "is-open"

	###*
	 * Closes the morph button, i.e.
	 * dialog -> button
	 * @param  {Object} element   The DOM node for the morph button component
	 * @return {Object}           The DOM node for the morph button component
	###
	closeMorphButton: (element) ->

		element.classList.remove "is-open"

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