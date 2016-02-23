class ZoomReset

	constructor: ->

		@el =
			inputs: document.querySelectorAll "input, select, textarea"
			metaTag: document.querySelector "meta[name=viewport]"

		if @el.inputs.length
			@addEventListeners()

	addEventListeners: ->

		for input in @el.inputs

			input.addEventListener "blur", (e) =>

				@el.metaTag.setAttribute "content", "width=device-width,initial-scale=1,maximum-scale=10"

			input.addEventListener "focus", (e) =>

				@el.metaTag.setAttribute "content", "width=device-width,initial-scale=1,maximum-scale=1"


module.exports = new ZoomReset