# TODO: work out how to run this test suite. Currently
# there are errors thrown by the SVGLoader class (3rd party)

# jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"
#
# describe "Page Transition", ->
#
# 	PageTransition = null
# 	svgLoader = require "../svg-loader/svg-loader.coffee"
#
# 	beforeEach ->
# 		loadFixtures "home-page.html"
#
# 		PageTransition = require "./page-transition.coffee"
#
# 		PageTransition.el.initialPageOverlay = document.querySelector ".js-page-transition__initial-overlay"
# 		PageTransition.el.pages = document.querySelectorAll ".js-page-transition__page-container"
# 		PageTransition.el.overlay = document.querySelector ".js-page-transition__overlay"
# 		PageTransition.el.triggers = document.querySelectorAll ".js-trigger-page-transition"
# 		PageTransition.el.wrapper = document.querySelector ".js-page-transition"
#
# 		PageTransition.loader = new SVGLoader PageTransition.el.overlay,
# 			easingIn: mina.easeinout
# 			speedIn: PageTransition.config.transitionTime
#
# 		PageTransition.pages = PageTransition.indexPages()
#
# 	it "should hide the overlay", ->
#
# 		PageTransition.hideOverlay()
#
# 		setTimeout ->
#
# 			expect(PageTransition.el.overlay.classList).toContain "is-shown"
# 			expect(PageTransition.el.wrapper.classList).toContain "is-loading"
#
# 		, PageTransition.config.transitionTime
#
# 	it "should hide a page", ->
#
# 		PageTransition.showPage "home"
#
# 		PageTransition.hidePage "home"
#
# 		expect(PageTransition.pages["home"].classList).not.toContain "is-shown"
#
# 	it "should index the available pages", ->
#
# 		pages = {}
#
# 		for page in PageTransition.el.pages
#
# 			pages[page.dataset.page] = page
#
# 		expect(PageTransition.indexPages()).toEqual pages
#
# 	it "should change page without running a transition", ->
#
# 		PageTransition.currentPage = "about"
# 		PageTransition.noTransition "contract"
# 		expect(PageTransition.currentPage).toMatch "contract"
#
# 	it "should remove the initial page overlay", ->
#
# 		expect(PageTransition.el.initialPageOverlay).not.toBe null
# 		PageTransition.removeInitialPageOverlay()
# 		expect(PageTransition.el.initialPageOverlay).not.toBe null
#
# 		setTimeout ->
#
# 			expect(PageTransition.el.initialPageOverlay).toBe null
#
# 		, PageTransition.config.initialDelay + 100
#
# 	it "should show the overlay", ->
#
# 		PageTransition.showOverlay()
# 		expect(PageTransition.el.overlay.classList).toContain "is-shown"
# 		expect(PageTransition.el.wrapper.classList).toContain "is-loading"
# 		PageTransition.hideOverlay()
#
# 	it "should show a page", ->
#
# 		PageTransition.pages["home"].classList.remove "is-shown"
# 		PageTransition.showPage "home"
# 		expect(PageTransition.pages["home"].classList).toContain "is-shown"
#
# 	it "should transition to another page", ->
#
# 		PageTransition.noTransition "home"
#
# 		expect(PageTransition.currentPage).toMatch "home"
#
# 		PageTransition.transition "about"
#
# 		expect(PageTransition.currentPage).toMatch "home"
#
# 		setTimeout ->
#
# 			expect(PageTransition.currentPage).toMatch "about"
# 			expect(window.location.href).toContain "/about/me"
# 			expect(window.scrollY).toBe 0
#
# 		, PageTransition.config.transitionDuration + 100