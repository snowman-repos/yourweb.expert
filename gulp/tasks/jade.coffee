"use strict"

notifier = require "node-notifier"

module.exports = (gulp, $, config) ->

	gulp.task "jade", ->

		gulp.src config.paths.html.entry + "*.jade"
		.pipe $.plumber()
		.pipe $.jade
			pretty: true
			data:
				description: config.description
				keywords: config.keywords
		.on "error", (err) ->
			notifier.notify
				message: "Error: " + err.message
			$.util.log $.util.colors.red err.message
		.pipe gulp.dest config.paths.html.dest