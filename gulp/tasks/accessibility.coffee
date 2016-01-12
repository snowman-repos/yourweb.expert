"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "accessibility", ->

		gulp.src config.paths.client.build + "/!styles/*.html"
		.pipe $.accessibility
			accessibilityLevel: "WCAG2A"
			reportLevels:
				error: true
				notice: false
				warning: true
			reportLocation: config.paths.client.build + "/reports"
			reportType: "json"