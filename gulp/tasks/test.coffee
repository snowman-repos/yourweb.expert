"use strict"

Karma = require("karma").Server

module.exports = (gulp, $, config) ->

	gulp.task "test", (done) ->

		new Karma(
			configFile: __dirname + "/../../karma.conf.js"
		, done).start()