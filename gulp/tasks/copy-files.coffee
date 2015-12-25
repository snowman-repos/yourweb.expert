"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "copy-files", ->

		gulp.src config.paths.fonts.entry
		.pipe gulp.dest config.paths.fonts.dest

		gulp.src config.paths.source + "/*.txt"
		.pipe gulp.dest config.paths.build

		gulp.src config.paths.source + "/*.json"
		.pipe gulp.dest config.paths.build

		gulp.src config.paths.source + "/*.xml"
		.pipe gulp.dest config.paths.build