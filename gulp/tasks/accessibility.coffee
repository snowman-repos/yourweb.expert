"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "accessibility", ->

		gulp.src config.paths.client.build + "/*.html"
		.pipe $.accessibility
			accessibilityLevel: "WCAG2A"
			force: true
			reportLevels:
				error: true
				notice: false
				warning: false
			reportLocation: config.paths.client.build + "/reports"
			reportType: "json"