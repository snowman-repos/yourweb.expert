"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "prod", ["build"], ->

		# usemin to go through html and replace references to all assets with minified and hashed versions
		gulp.src config.paths.html.dest + "/*.html"
		.pipe $.usemin
			css: [$.minifyCss, $.rev]
			js: [$.uglify(), $.rev()]
			html:[$.htmlmin collapseWhitespace: true]
		.pipe gulp.dest config.paths.build