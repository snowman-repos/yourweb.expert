class MorphButton

	constructor: (el) ->

		@el =
			close: el.querySelector ".js-morph-button-close"
			component: el
			open: el.querySelector ".js-morph-button-open"

		@addEventListeners()

		setTimeout =>

			@el.component.classList.remove "is-hidden"

		, 1000

	addEventListeners: ->

		@el.open.addEventListener "click", (e) =>
			@el.component.classList.add "is-open"

		@el.close.addEventListener "click", (e) =>
			@el.component.classList.remove "is-open"

module.exports = do ->

	morphButtons = document.querySelectorAll ".js-morph-button"

	for morphButton in morphButtons

		new MorphButton morphButton