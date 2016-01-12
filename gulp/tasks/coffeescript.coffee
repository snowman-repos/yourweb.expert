"use strict"

browserify = require "browserify"
buffer = require "vinyl-buffer"
# coffeelint = require "coffeelint-cjsx"
notifier = require "node-notifier"
source = require "vinyl-source-stream"

# coffeeReactTransform= require "coffee-react-transform"

module.exports = (gulp, $, config) ->

	gulp.task "coffeescript", ->

		# gulp.src config.paths.js.entry + "**/*.coffee"
		# .pipe $.plumber()
		# .pipe $.coffeelintCjsx()
		# .pipe $.coffeelintCjsx.reporter()

		b = browserify
			entries: config.paths.js.entry + config.names.js.source
			debug: true
			transform: ["coffee-reactify"]

		b2 = browserify
			entries: config.paths.js.entry + "service-worker.coffee"
			debug: true
			transform: ["coffeeify"]

		b.bundle()
			.pipe source config.names.js.compiled
			.on "error", (err) ->
				notifier.notify
					message: "Error: " + err.message
				$.util.log $.util.colors.red err.message
				@.end()
			.pipe $.plumber()
			.pipe buffer()
			.pipe $.if config.env is "dev", $.sourcemaps.init()
			.pipe $.header "/* " + config.names.project + " : " + config.version + " : " + new Date() + " */"
			.pipe $.size
				showFiles: true
			.pipe $.if config.env is "dev", $.sourcemaps.write "./"
			.pipe gulp.dest config.paths.js.dest

		# gulp.src config.paths.js.entry + "service-worker.coffee"
		# .pipe $.plumber()
		# .pipe $.if config.env is "dev", $.sourcemaps.init()
		# .pipe $.coffee()
		# .pipe $.header "/* " + config.names.project + " : " + config.version + " : " + new Date() + " */"
		# .pipe $.size
		# 	showFiles: true
		# .pipe $.if config.env is "dev", $.sourcemaps.write "./"
		# .pipe $.if config.env isnt "dev", $.uglify()
		# .pipe gulp.dest config.paths.build

		b2.bundle()
			.pipe source "service-worker.js"
			.on "error", (err) ->
				notifier.notify
					message: "Error: " + err.message
				$.util.log $.util.colors.red err.message
				@.end()
			.pipe $.plumber()
			.pipe buffer()
			.pipe $.if config.env is "dev", $.sourcemaps.init()
			.pipe $.header "/* " + config.names.project + " : " + config.version + " : " + new Date() + " */"
			.pipe $.size
				showFiles: true
			.pipe $.if config.env is "dev", $.sourcemaps.write "./"
			.pipe $.if config.env isnt "dev", $.uglify()
			.pipe gulp.dest config.paths.build