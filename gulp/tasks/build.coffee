"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "build", ["jade", "coffeescript", "stylus", "copy-files", "libs"], ->