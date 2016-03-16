"use strict"

psi = require "psi"

module.exports = (gulp, $, config) ->

	gulp.task "pagespeed", ->

		psi config.url,
			strategy: "mobile"
		.then (data) ->

			$.util.log "\nMOBILE\n=========="

			usabilityScore = data.ruleGroups.USABILITY.score

			if usabilityScore >= 95 # performance budget
				$.util.log $.util.colors.green "Speed score: " + usabilityScore
			else
				$.util.log $.util.colors.red "Speed score: " + usabilityScore

			speedScore = data.ruleGroups.SPEED.score

			if speedScore >= 95 # performance budget
				$.util.log $.util.colors.green "Speed score: " + speedScore
			else
				$.util.log $.util.colors.red "Speed score: " + speedScore

		psi config.url,
			strategy: "desktop"
		.then (data) ->

			$.util.log "\nDESKTOP\n=========="

			score = data.ruleGroups.SPEED.score

			if score >= 95 # performance budget
				$.util.log $.util.colors.green "Speed score: " + score
			else
				$.util.log $.util.colors.red "Speed score: " + score