api = require "../api/api.coffee"

class Blog

	constructor: ->

		@el =
			component: document.querySelector ".js-blog"
			list: document.querySelector ".js-blog-list"

		if @el.component and @el.list

			@getArticles()
			.then (response)->

				response.json()

			.then (data) =>

				articles = data
				@populateList articles
				@el.component.classList.add "is-loaded"

				menuItem = @getMenuItem()
				if menuItem then menuItem.classList.remove "is-hidden"

			.catch (reason) =>

				console.error reason
				@el.component.parentNode.removeChild @el.component

				menuItem = @getMenuItem()
				if menuItem then menuItem.parentNode.removeChild menuItem

				# trigger resize to update the navigation scroll spy functionality
				window.dispatchEvent new Event "resize"

	formateDate: (date) ->

		date = new Date date
		day = date.getDate()
		month = @getMonth date.getMonth()

		formatedDate = day + " " + month

	getArticles: ->

		url = api.getURL() + "/blog/"

		fetch url

	getListItem: (article) ->

		item = document.createElement "li"
		item.classList.add "c-blog__list__item"

		link = document.createElement "a"
		link.classList.add "c-blog__list__item__link"
		link.href = article.post_url
		link.title = "Read more"

		heading = document.createElement "h2"
		heading.classList.add "c-blog__list__item__heading"
		heading.innerText = article.title

		date = document.createElement "div"
		date.classList.add "c-blog__list__item__date"
		date.innerHTML = @formateDate article.date

		link.appendChild heading
		link.appendChild date

		item.appendChild link

		item

	getMenuItem: ->

		navigation = document.querySelector ".js-navigation-menu"
		link = navigation.querySelector "[href='#" + @el.component.id + "']"
		menuItem = link.parentNode

	getMonth: (month) ->

		monthNames = [
			"Jan"
			"Feb"
			"Mar"
			"Apr"
			"May"
			"Jun"
			"Jul"
			"Aug"
			"Sep"
			"Oct"
			"Nov"
			"Dec"
		]

		monthNames[month]

	getOrdinal: (day) ->

		if day > 20 or day < 10

			switch day % 10
				when 1 then return "st"
				when 2 then return "nd"
				when 3 then return "rd"

		"th"

	populateList: (articles) ->

		articles = articles.slice 0, 5

		@el.list.innerHTML = ""

		for article in articles

			@el.list.appendChild @getListItem article

module.exports = new Blog
