"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "serve", ->

		$.util.log "**********************************"
		$.util.log "Don't forget to run MongoDB first!"
		$.util.log "mongod"
		$.util.log "**********************************"

		$.nodemon
			env:
				NODE_ENV: "development"
			ext: "coffee"
			script: config.paths.server.entry