###*
 * This is a fun little class to show animated
 * checkmarks in sequence alongside the
 * descriptions of each service I provide. The
 * class is used when the user scrolls to the
 * services section, so it's called from inside
 * the Waypoints class.
###
class Services

	constructor: ->

		@checkmarks = Array.prototype.slice.call document.querySelectorAll ".js-checkmark"

		@checked = false

		# The time in ms between each checkmark animation
		@config =
			delay: 200

	###*
	 * This function checks the checkmarks in sequence
	 * and is called when the user scrolls to the
	 * services section.
	###
	checkCheckmarks: ->

		# Only check the checkmarks if there are
		# any and they're not already checked
		if !@checked and @checkmarks.length

			checkmarkCount = @checkmarks.length

			# Duplicate the array of checkmarks
			tmp = @checkmarks.slice 0

			# Show the checkmarks at intervals
			@interval = setInterval =>

				if checkmarkCount is 0
					clearInterval @interval
				else

					# Get the next checkmark and check it
					# (we're not using classList due to
					# sketchy support with SVGs)
					# tmp.shift().classList.add "is-checked"
					el = tmp.shift()
					el.setAttribute "class", el.getAttribute("class") + " is-checked"
					checkmarkCount--

			, @config.delay

			@checked = true


module.exports = new Services