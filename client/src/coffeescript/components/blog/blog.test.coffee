jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Blog", ->

	Blog = require "./blog.coffee"
	Navigation = require "../navigation/navigation.coffee"
	date = new Date()
	dummyData = [
		date: new Date("Mon Feb 22 2016 00:08:32 GMT+0800 (CST)")
		post_url: "URL"
		title: "title"
	,
		date: new Date("Mon Feb 22 2016 00:08:32 GMT+0800 (CST)")
		post_url: "URL"
		title: "title"
	,
		date: new Date("Mon Feb 22 2016 00:08:32 GMT+0800 (CST)")
		post_url: "URL"
		title: "title"
	,
		date: new Date("Mon Feb 22 2016 00:08:32 GMT+0800 (CST)")
		post_url: "URL"
		title: "title"
	,
		date: new Date("Mon Feb 22 2016 00:08:32 GMT+0800 (CST)")
		post_url: "URL"
		title: "title"
	,
		date: new Date("Mon Feb 22 2016 00:08:32 GMT+0800 (CST)")
		post_url: "URL"
		title: "title"
	]

	beforeEach ->
		loadFixtures "home-page.html"
		Blog.el.component = document.querySelector ".js-blog"
		Blog.el.list = document.querySelector ".js-blog-list"
		Blog.el.navigation = Navigation.el.menu = document.querySelector ".js-navigation-menu"

		spyOn(Blog, "getArticles").and.callFake ->
			test: "ok"

	it "correctly format dates", ->

		expect(Blog.formatDate(new Date("Feb 19 2016"))).toMatch "19<sup>th</sup> Feb"
		expect(Blog.formatDate(new Date("Jan 1 2016"))).toMatch "1<sup>st</sup> Jan"
		expect(Blog.formatDate(new Date("Nov 3 2016"))).toMatch "3<sup>rd</sup> Nov"
		expect(Blog.formatDate(new Date("Nov 13 2016"))).toMatch "13<sup>th</sup> Nov"
		expect(Blog.formatDate(new Date("Jul 22 2016"))).toMatch "22<sup>nd</sup> Jul"
		expect(Blog.formatDate(new Date("Mar 5 2016"))).toMatch "5<sup>th</sup> Mar"

	it "gets data", ->

		data = Blog.getArticles()
		expect(data).toEqual
			test: "ok"

	it "generates a list item", ->

		date = new Date()
		formattedDate = Blog.formatDate date

		article =
			date: date
			post_url: "url"
			title: "title"

		li = Blog.getListItem article
		result = document.createElement "div"
		result.appendChild li
		expected = '<li class="o-blog-post-list__item"><a class="o-blog-post-list__item__link" href="url" title="Read more"><h2 class="o-blog-post-list__item__heading">title</h2><div class="o-blog-post-list__item__date">' + formattedDate + '</div></a></li>'

		expect(result.innerHTML).toMatch expected

	it "gets a navigation menu item", ->

		Navigation.addItem Blog.el.component

		item = Blog.getMenuItem()
		result = document.createElement "div"
		result.appendChild item

		expect(result.innerHTML).toBe '<li class="o-navigation__menu__item is-hidden"><a href="#blog" title="Read my thoughts" class="o-navigation__menu__item__link"></a></li>'

	it "gets the short name of the month", ->

		expect(Blog.getMonth(0)).toMatch "Jan"
		expect(Blog.getMonth(1)).toMatch "Feb"
		expect(Blog.getMonth(2)).toMatch "Mar"
		expect(Blog.getMonth(3)).toMatch "Apr"
		expect(Blog.getMonth(4)).toMatch "May"
		expect(Blog.getMonth(5)).toMatch "Jun"
		expect(Blog.getMonth(6)).toMatch "Jul"
		expect(Blog.getMonth(7)).toMatch "Aug"
		expect(Blog.getMonth(8)).toMatch "Sep"
		expect(Blog.getMonth(9)).toMatch "Oct"
		expect(Blog.getMonth(10)).toMatch "Nov"
		expect(Blog.getMonth(11)).toMatch "Dec"

	it "gets the ordinal for a date", ->

		expect(Blog.getOrdinal(1)).toMatch "st"
		expect(Blog.getOrdinal(2)).toMatch "nd"
		expect(Blog.getOrdinal(3)).toMatch "rd"
		expect(Blog.getOrdinal(4)).toMatch "th"
		expect(Blog.getOrdinal(5)).toMatch "th"
		expect(Blog.getOrdinal(11)).toMatch "th"
		expect(Blog.getOrdinal(12)).toMatch "th"
		expect(Blog.getOrdinal(20)).toMatch "th"
		expect(Blog.getOrdinal(21)).toMatch "st"
		expect(Blog.getOrdinal(22)).toMatch "nd"
		expect(Blog.getOrdinal(23)).toMatch "rd"
		expect(Blog.getOrdinal(24)).toMatch "th"
		expect(Blog.getOrdinal(30)).toMatch "th"
		expect(Blog.getOrdinal(31)).toMatch "st"

	it "removes the blog component and the corresponding navigation menu item if data cannot be retrieved", ->

		Navigation.addItem Blog.el.component

		Blog.handleFailure()

		expect(Blog.getMenuItem()).toBe undefined
		expect(document.querySelector ".js-blog").toBe null

	it "displays the component and its corresponding navigation menu item", ->

		Navigation.addItem Blog.el.component
		menuItem = Blog.getMenuItem()

		Blog.handleSuccess dummyData

		expect(Blog.el.component.classList).toContain "is-loaded"
		expect(menuItem.classList).not.toContain "is-hidden"

	it "populates a list of articles", ->

		Blog.populateList dummyData

		expect(Blog.el.list.innerHTML).toMatch '<li class="o-blog-post-list__item"><a class="o-blog-post-list__item__link" href="URL" title="Read more"><h2 class="o-blog-post-list__item__heading">title</h2><div class="o-blog-post-list__item__date">22<sup>nd</sup> Feb</div></a></li><li class="o-blog-post-list__item"><a class="o-blog-post-list__item__link" href="URL" title="Read more"><h2 class="o-blog-post-list__item__heading">title</h2><div class="o-blog-post-list__item__date">22<sup>nd</sup> Feb</div></a></li><li class="o-blog-post-list__item"><a class="o-blog-post-list__item__link" href="URL" title="Read more"><h2 class="o-blog-post-list__item__heading">title</h2><div class="o-blog-post-list__item__date">22<sup>nd</sup> Feb</div></a></li><li class="o-blog-post-list__item"><a class="o-blog-post-list__item__link" href="URL" title="Read more"><h2 class="o-blog-post-list__item__heading">title</h2><div class="o-blog-post-list__item__date">22<sup>nd</sup> Feb</div></a></li><li class="o-blog-post-list__item"><a class="o-blog-post-list__item__link" href="URL" title="Read more"><h2 class="o-blog-post-list__item__heading">title</h2><div class="o-blog-post-list__item__date">22<sup>nd</sup> Feb</div></a></li>'