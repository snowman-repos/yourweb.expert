"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "images", ->

		gulp.src config.paths.images.entry + "**/*.{jpg,png,gif}"
		.pipe $.plumber()
		.pipe $.imagemin
			cache: false
		.pipe $.size
			showFiles: false
		.pipe gulp.dest config.paths.images.dest

		gulp.src config.paths.images.entry + "**/*/.svg"
		.pipe $.plumber()
		.pipe $.svgmin()
		.pipe $.size
			showFiles: false
		.pipe gulp.dest config.paths.images.dest

		gulp.src config.paths.images.entry + "*.xml"
		.pipe gulp.dest config.paths.images.dest