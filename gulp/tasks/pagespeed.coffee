"use strict"

psi = require "psi"

module.exports = (gulp, $, config) ->

	gulp.task "pagespeed", ->

		psi config.url,
			strategy: "mobile"
			threshold: 85
		.then (data) ->
			$.util.log "Speed score: " + data.ruleGroups.SPEED.score
			$.util.log "Usability score: " + data.ruleGroups.USABILITY.score

		psi config.url,
			strategy: "desktop"
			threshold: 85
		.then (data) ->
			$.util.log "Speed score: " + data.ruleGroups.SPEED.score
			$.util.log "Usability score: " + data.ruleGroups.USABILITY.score
