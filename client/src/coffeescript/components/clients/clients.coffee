class Clients

	constructor: (logos) ->

		@logos = logos

		@shown = false

		@config =
			delay: 100

	showLogos: ->

		if !@shown

			logoCount = @logos.length

			tmp = @logos.slice 0

			@interval = setInterval =>
				tmp.shift().classList.add "is-shown"
				logoCount--
				if logoCount is 0
					clearInterval @interval
			, @config.delay

			@shown = true


logos = Array.prototype.slice.call document.querySelectorAll ".js-client-logo"
module.exports = new Clients logos