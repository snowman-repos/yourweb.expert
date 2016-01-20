"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "copy-files", ->

		gulp.src config.paths.client.fonts.entry
		.pipe gulp.dest config.paths.client.fonts.dest

		gulp.src config.paths.client.source + "/*.txt"
		.pipe gulp.dest config.paths.client.build

		gulp.src config.paths.client.source + "/*.json"
		.pipe gulp.dest config.paths.client.build

		gulp.src config.paths.client.source + "/*.xml"
		.pipe gulp.dest config.paths.client.build

		gulp.src config.paths.client.source + "/*.pdf"
		.pipe gulp.dest config.paths.client.build