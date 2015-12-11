"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "libs", ->

		paths = config.libs.map (p) -> path.resolve  "../." + config.paths.lib.entry, p
		gulp.src paths
		.pipe gulp.dest "../." + config.paths.lib.dest