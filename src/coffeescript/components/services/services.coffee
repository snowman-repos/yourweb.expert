class Services

	constructor: (checkmarks) ->

		@checkmarks = checkmarks

		@checked = false

		@config =
			delay: 200

	checkCheckmarks: ->

		if !@checked

			checkmarkCount = @checkmarks.length

			tmp = @checkmarks.slice 0

			@interval = setInterval =>
				tmp.shift().classList.add "is-checked"
				checkmarkCount--
				if checkmarkCount is 0
					clearInterval @interval
			, @config.delay

			@checked = true


checkmarks = Array.prototype.slice.call document.querySelectorAll ".js-checkmark"
module.exports = new Services checkmarks