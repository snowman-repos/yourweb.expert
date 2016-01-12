navigation = require "../navigation/navigation.coffee"
scrollMonitor = require "scrollmonitor"
waypoints = require "../waypoints/waypoints.coffee"

class ScrollWatcher

	constructor: (el) ->

		@el = el

		navigation.addItem @el

		scrollPoints = document.querySelectorAll ".js-scroll-point"
		if @el is scrollPoints[0]
			navigation.activateItem @el

		@inViewFunction = @el.dataset.whenInView
		@watcher = scrollMonitor.create el
		@watchForScroll()

	watchForScroll: ->

		@watcher.fullyEnterViewport =>
			@el.classList.add "is-in-view"
			navigation.activateItem @el
			if @inViewFunction then waypoints.run @inViewFunction

		@watcher.exitViewport =>
			@el.classList.remove "is-in-view"

module.exports = do ->

	scrollPoints = document.querySelectorAll ".js-scroll-point"

	for scrollPoint in scrollPoints

		new ScrollWatcher scrollPoint