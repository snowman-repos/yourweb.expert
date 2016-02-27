"use strict"

critical = require "critical"
notifier = require "node-notifier"
runSequence = require "run-sequence"

module.exports = (gulp, $, config) ->

	finish = (stage) ->

		$.util.log $.util.colors.green "Finished: " + stage
		process.exit 0

	gulp.task "prod-optimise", (callback) ->

		jsFilter = $.filter "**/*.js", restore: true
		cssFilter = $.filter "**/*.css", restore: true
		notHTMLFilter = $.filter ["**/*", "!**/*.html"], restore: true

		gulp.src config.paths.client.html.dest + "/**/*.html"
		.pipe $.useref()
		.pipe gulp.dest config.paths.client.build

		gulp.src config.paths.client.css.dest + "/" + config.names.css.compiled
		.pipe $.cssnano()
		.pipe $.size
			showFiles: true
		.pipe gulp.dest config.paths.client.css.dest

		gulp.src config.paths.client.js.dest + "/" + config.names.js.compiled
		.pipe $.uglify()
		.pipe $.size
			showFiles: true
		.pipe gulp.dest config.paths.client.js.dest

		gulp.src config.paths.client.html.dest + "/*.html"
		.pipe $.htmlmin()
		.pipe $.size
			showFiles: true
		.pipe gulp.dest config.paths.client.html.dest

		# setTimeout ->
		#
		# 	finish "optimisation"
		#
		# , 10000

		callback()

	gulp.task "prod-inline-css", (callback) ->

		# gulp.src config.paths.client.html.dest + "/**/*.html"
		# .pipe $.inlineSource
		# 	compress: true
		# .pipe gulp.dest config.paths.client.html.dest

		# critical.generate
		# 	base: config.paths.client.build + "/"
		# 	dest: config.paths.client.build + "/" + config.names.html.compiled
		# 	extract: false
		# 	height: 900
		# 	inline: true
		# 	minify: true
		# 	src: config.names.html.compiled
		# 	width: 1300
		# , (err, output) ->
		#
		# 	$.util.log $.util.colors.green "Critical CSS inlined!"
		#
		# 	if err
		#
		# 		notifier.notify
		# 			message: "Error: " + err.message
		#
		# 		$.util.log $.util.colors.red err.message
		#
		# 	callback()

	gulp.task "prod", (callback) ->

		config.env = "prod"

		runSequence "reset", "build", ->

			# Ugh... apologies to the universe...
			# Seems runSequence doesn't wait for tasks to
			# FINISH before running the next
			setTimeout ->

				finish "build"

			, 8000