"use strict"

module.exports = (gulp, $, config) ->

	gulp.task "default", ["build"], ->

		# Give first-time users a little help
		setTimeout ->
			$.util.log "**********************************************"
			$.util.log "* gulp                  (development build)"
			$.util.log "* gulp reset            (rm /public)"
			$.util.log "* gulp prod             (production build)"
			$.util.log "* gulp dev              (build and run dev server at localhost:8080)"
			$.util.log "* gulp test             (run unit tests)"
			$.util.log "* gulp accessibility    (check against WCAG2 guidelines)"
			$.util.log "* gulp pagespeed        (test against Google pagespeed)"
			$.util.log "**********************************************"
		, 3000