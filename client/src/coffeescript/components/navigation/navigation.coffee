smoothScroll = require "smoothscroll"

###*
 * This class builds the navigation menu, based
 * on the waypoint sections, and handles its
 * functionality.
###
class Navigation

	constructor: ->

		@el =
			menu: document.querySelector ".js-navigation-menu"

		# This will maintain a stateful record
		# of navigation menu item links
		@links = {}

		@config =
			scrollDuration: 200

	###*
	 * Make a single navigation menu item link active.
	 * @param  {Object} item A DOM node for a navigation menu item
	 * @return {Object}      The JSON object representing the collection of navigation menu items
	###
	activateItem: (item) ->

		@resetItems()

		if @el.menu

			@links[item.id].classList.add "is-active"

	###*
	 * Attach an event listener to a navigation menu
	 * item link so that when it's clicked the browser
	 * smoothly scrolls to the target section.
	 * @param {Object} link   The DOM node of the navigation menu item link
	 * @param {String} target The ID attribute value of the target section
	###
	addEventListener: (link, target) ->

		link.addEventListener "click", (e) =>

			e.preventDefault()
			target = document.querySelector "#" + target
			smoothScroll target.offsetTop
			ga "send", "event", "navigation", "click", "navigate to section", target,
				nonInteraction: 1

	###*
	 * Add a navigation menu item to the menu.
	 * @param {Object} item A DOM node for a navigation menu item
	###
	addItem: (item) ->

		if @el.menu

			@el.menu.appendChild @generateListItem item

	###*
	 * Generate the required DOM nodes for a navigation
	 * menu list item.
	 * @param  {Object} item The DOM node for the section to be navigated to
	 * @return {Object}      The DOM node for the generated list item
	###
	generateListItem: (item) ->

		listItem = document.createElement "li"
		listItem.classList.add "o-navigation__menu__item"
		# some scroll-to sections should not be displayed until
		# their data has loaded; consequently, the corresponding
		# navigation menu item should not be displayed either
		if item.dataset.waitForLoad then listItem.classList.add "is-hidden"

		link = document.createElement "a"
		link.href = "#" + item.id
		link.title = item.dataset.navTitle || ""
		link.classList.add "o-navigation__menu__item__link"

		listItem.appendChild link

		@addEventListener link, item.id

		# Add the navigation item link to the state object
		@links[item.id] = link

		listItem

	###*
	 * Make all navigation item links inactive.
	###
	resetItems: ->

		for key, link of @links
			link.classList.remove "is-active"


module.exports = new Navigation