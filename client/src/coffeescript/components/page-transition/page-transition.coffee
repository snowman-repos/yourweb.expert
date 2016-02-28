Page = require "page"
svgLoader = require "../svg-loader/svg-loader.coffee"

###*
 * This class handles routing and page transitions,
 * e.g.
 * /about/me
 * /contract
###
class PageTransition

	constructor: ->

		@el =
			initialPageOverlay: document.querySelector ".js-page-transition__initial-overlay"
			pages: document.querySelectorAll ".js-page-transition__page-container"
			overlay: document.querySelector ".js-page-transition__overlay"
			triggers: document.querySelectorAll ".js-trigger-page-transition"
			wrapper: document.querySelector ".js-page-transition"

		@currentPage = "home"

		@config =
			initialDelay: 1500 # the initial 'loading' time
			transitionDuration: 1000 # the 'loading' time between pages
			transitionTime: 400 # the time for the page transition animation

		# Only run the code if there are pages to be
		# transitioned
		if @el.wrapper and @el.pages.length

			# SVGLoader handles the transition animation
			@loader = loader = new SVGLoader @el.overlay,
				easingIn: mina.easeinout
				speedIn: @config.transitionTime

			@pages = @indexPages()

			@addEventListeners()
			@setupRouting()

	###*
	 * Trigger a page transition every time a
	 * trigger link is clicked.
	###
	addEventListeners: ->

		for trigger in @el.triggers

			trigger.addEventListener "click", (e) =>

				e.preventDefault()

				@transition e.target.dataset.page

				ga "send", "event", "page transition trigger", "click", "go to page", e.target.dataset.page,
					nonInteraction: 1

	###*
	 * Hide the page transition overlay.
	 * @return {Object} The DOM node for the overlay
	###
	hideOverlay: ->

		@loader.hide()
		@el.wrapper.classList.remove "is-loading"

		setTimeout =>

			@el.overlay.classList.remove "is-shown"

		, @config.transitionTime

	###*
	 * Hide a page.
	 * @param  {String} page A reference to the page to be hidden
	 * @return {Object}      The DOM node for the page container
	###
	hidePage: (page) ->

		@pages[page].classList.remove "is-shown"

	###*
	 * Determine which pages are available.
	 * for transitioning.
	 * @return {Object} A collection of DOM nodes for pages, referenced by a String ID
	###
	indexPages: ->

		pages = {}

		for page in @el.pages

			pages[page.dataset.page] = page

		pages

	###*
	 * Show a page without running the transition,
	 * i.e. when navigating directly to a URL.
	 * @param  {String} targetPage A reference to the page to be transitioned to
	###
	noTransition: (targetPage) ->

		if @currentPage isnt targetPage

			@hidePage @currentPage
			@showPage targetPage
			@resizeWindow()

			@currentPage = targetPage

	###*
	 * An overay is always shown on itinial page load.
	 * That's because when navigating directly to a URL,
	 * the home page will always be shown first because
	 * the JavaScript is loaded last. By showing the
	 * overlay, it acts as a cool loading screen, hiding
	 * when the JavaScript has been loaded and the target
	 * page has been displayed.
	 * @return {Object} The DOM node for the initial page overlay
	###
	removeInitialPageOverlay: ->

		@el.initialPageOverlay.classList.add "is-hidden"

		@hideOverlay()

		setTimeout =>

			@el.initialPageOverlay.parentNode.removeChild @el.initialPageOverlay

		, @config.initialDelay

	###*
	 * Trigger resize to update the full-height sections
	###
	resizeWindow: ->

		window.dispatchEvent new CustomEvent "resize"

	###*
	 * This uses PageJS to handle the routing. If
	 * the user navigates directly to any of these
	 * routes then the appropriate page will be
	 * displayed and then the initial overlay hidden.
	 * @return {[type]} [description]
	###
	setupRouting: ->

		# Establish the routes
		# (no need for transitions because the
		# initial overlay is visible on page load)
		Page "/", =>
			console.info "Home page"
			@noTransition "home"
			ga "send", "pageview", "/"

		Page "/about/me", =>
			console.info "About page"
			@noTransition "about"
			ga "send", "pageview", "/about/me"

		Page "/contract", =>
			console.info "Contract page"
			@noTransition "contract"
			ga "send", "pageview", "/contract"

		# Initialise PageJS
		Page()

		# Hide the loading screen to reveal the page
		@removeInitialPageOverlay()

	###*
	 * Show the page transition overlay and begin the transition.
	 * @return {Object} An instance of SVGLoader
	###
	showOverlay: ->

		@el.wrapper.classList.add "is-loading"
		@el.overlay.classList.add "is-shown"
		@loader.show()

	###*
	 * Display a page.
	 * @param  {String} page A reference to the page to be displayed
	 * @return {Object}      The DOM node for the page that is displayed
	###
	showPage: (page) ->

		@pages[page].classList.add "is-shown"

	###*
	 * Run the page transition from the current
	 * page to the target page.
	 * @param  {String} targetPage A reference to the target page
	###
	transition: (targetPage) ->

		# Don't bother with this if we're already on
		# the target page
		if @currentPage isnt targetPage

			# Show the overlay and begin the transition
			@showOverlay()

			# After 1s update the URL and hide the overlay
			# (yes, the overlay is just to make it seem like
			# the page is loaded remotely really fast ;)
			setTimeout =>

				@hidePage @currentPage
				@showPage targetPage

				# Update the URL and browser history using PageJS
				switch targetPage
					when "home" then Page "/"
					when "about" then Page "/about/me"
					when "contract" then Page "/contract"

				# Ensure the user is at the top of the page
				# before the overlay is hidden
				window.scrollTo 0,0

				@hideOverlay()

				@currentPage = targetPage

			, @config.transitionDuration


module.exports = new PageTransition