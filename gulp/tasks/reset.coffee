"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "reset", ->

		gulp.src config.paths.build + "*", read: false
			.pipe $.clean
				force: true