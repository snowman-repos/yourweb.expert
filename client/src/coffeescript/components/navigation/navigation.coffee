smoothScroll = require "smoothscroll"

class Navigation

	constructor: ->

		@el =
			menu: document.querySelector ".js-navigation-menu"

		@links = {}

		@config =
			scrollDuration: 200

	activateItem: (item) ->

		@resetLinks()
		@links[item.id].classList.add "is-active"

	addItem: (item) ->

		listItem = document.createElement "li"
		listItem.classList.add "o-navigation__menu__item"
		if item.dataset.waitForLoad then listItem.classList.add "is-hidden"

		link = document.createElement "a"
		link.href = "#" + item.id
		link.title = item.dataset.navTitle || ""
		link.classList.add "o-navigation__menu__item__link"

		listItem.appendChild link
		@el.menu.appendChild listItem

		@links[item.id] = link

		link.addEventListener "click", (e) =>

			e.preventDefault()

			target = document.querySelector "#" + item.id

			smoothScroll target.offsetTop

	resetLinks: ->

		for key, link of @links
			link.classList.remove "is-active"


module.exports = new Navigation