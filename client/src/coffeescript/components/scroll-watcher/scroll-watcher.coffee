Navigation = require "../navigation/navigation.coffee"
scrollMonitor = require "scrollmonitor"
Waypoints = require "../waypoints/waypoints.coffee"

###*
 * This class updates the highlight status of navigation
 * menu items based on the scroll position, so that
 * corresponding menu items are highlighted when target
 * sections are scrolled into view. It also calls
 * functions that should be run when sections are scrolled
 * into view, based on functions specified in the 'when-in-view'
 * data attribute on each target section.
###
class ScrollWatcher

	constructor: ->

		@el =
			scrollPoints: document.querySelectorAll ".js-scroll-point"

		if @el.scrollPoints.length

			for scrollPoint, index in @el.scrollPoints

				@setupNavigation scrollPoint, index

				@attachScrollEventListeners scrollPoint, scrollMonitor.create scrollPoint

	###*
	 * For each scroll point we here specify what to do
	 * when they are scrolled in and out of view.
	 * @param  {Object} scrollPoint The DOM node for the scroll point
	 * @param  {Object} watcher     An instance of scrollMonitor that watches this scroll point
	###
	attachScrollEventListeners: (scrollPoint, watcher) ->

		watcher.fullyEnterViewport =>

			@scrolledIntoView scrollPoint

		watcher.exitViewport =>

			@scrolledOutOfView scrollPoint

	###*
	 * Run a function when the scrollPoint is
	 * scrolled into view. Functions are specified
	 * via a reference in the when-in-view
	 * data-attribute on each scroll point and are
	 * handled by the Waypoints class.
	 * @param  {Object} scrollPoint The DOM node for the scroll point (i.e. a page section)
	###
	runInViewFunction: (scrollPoint) ->

		inViewFunction = scrollPoint.dataset.whenInView
		if inViewFunction then Waypoints.run inViewFunction

	###*
	 * The navigation menu is built automatically
	 * based on scroll points. This function calls
	 * the appropriate functions in the Navigation
	 * class to both add and if necessary activate
	 * a navigation menu item.
	 * @param  {Object}  scrollPoint The DOM node for the scroll point (i.e. a page section)
	 * @param  {Integer} index       The index of the scroll point in the @el.scrollPoints array (i.e. the order placement of the section on the page)
	###
	setupNavigation: (scrollPoint, index) ->

		# Add an item in the navigation menu
		Navigation.addItem scrollPoint

		# If this scroll point is the first in the list,
		# i.e. the first matching DOM node in the document,
		# then activate the corresponding navigation item
		# because we're at the top of the page. (This assumes
		# that nothing comes before the first scroll point
		# in the markup)
		if index is 0
			Navigation.activateItem scrollPoint

	scrolledIntoView: (scrollPoint) ->

		scrollPoint.classList.add "is-in-view"

		Navigation.activateItem scrollPoint

		@runInViewFunction scrollPoint

	scrolledOutOfView: (scrollPoint) ->

		scrollPoint.classList.remove "is-in-view"

module.exports = new ScrollWatcher