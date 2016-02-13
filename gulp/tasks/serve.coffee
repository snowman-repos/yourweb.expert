"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "serve", ->

		$.util.log $.util.colors.green "**********************************"
		$.util.log $.util.colors.green "Don't forget to run MongoDB first!"
		$.util.log $.util.colors.green "> mongod"
		$.util.log $.util.colors.green "**********************************"

		$.nodemon
			env:
				NODE_ENV: "development"
			ext: "coffee"
			script: config.paths.server.entry