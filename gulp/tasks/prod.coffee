"use strict"

critical = require "critical"
notifier = require "node-notifier"
runSequence = require "run-sequence"

module.exports = (gulp, $, config) ->

	gulp.task "prod-optimise", (callback) ->

		jsFilter = $.filter "**/*.js", restore: true
		cssFilter = $.filter "**/*.css", restore: true
		notHTMLFilter = $.filter ["**/*", "!**/*.html"], restore: true

		gulp.src config.paths.client.html.dest + "/**/*.html"
		.pipe $.useref()
		.pipe jsFilter
		.pipe $.uglify()
		.pipe $.size
			showFiles: true
		.pipe jsFilter.restore
		.pipe cssFilter
		# .pipe $.uncss
		# 	html: config.paths.client.html.dest + "/index.html"
		.pipe $.cssnano()
		.pipe $.size
			showFiles: true
		.pipe cssFilter.restore
		.pipe notHTMLFilter
		.pipe $.rev()
		.pipe notHTMLFilter.restore
		.pipe $.revReplace()
		.pipe gulp.dest config.paths.client.build

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

	gulp.task "prod", (callback)->

		config.env = "prod"

		runSequence "reset", "build", ->

			# Ugh... apologies to the universe...
			# Seems runSequence doesn't wait for tasks to
			# FINISH before running the next
			setTimeout ->

				gulp.start "prod-optimise", ->

					# setTimeout ->
					#
					# 	gulp.start "prod-inline-css"
					#
					# , 8000

			, 8000