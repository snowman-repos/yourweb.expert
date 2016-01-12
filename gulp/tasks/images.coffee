"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "images", ->

		gulp.src config.paths.client.images.entry + "**/*.{jpg,png,gif,svg,webp}"
		.pipe $.plumber()
		.pipe $.imagemin
			cache: false
		.pipe $.size
			showFiles: false
		.pipe gulp.dest config.paths.client.images.dest

		gulp.src config.paths.client.images.entry + "*.xml"
		.pipe gulp.dest config.paths.client.images.dest