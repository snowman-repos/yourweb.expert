"use strict"
version = "v1.01::"
staticCacheName = version + "static"
pagesCacheName = version + "pages"
imagesCacheName = version + "images"

updateStaticCache = ->

	caches.open(staticCacheName)
	.then (cache) ->
		# These items must be cached for the Service Worker to complete installation
		cache.addAll [
			"/scripts/main.min.js"
			"/styles/main.min.css"
			"/images/darryl-snow.jpg"
			"/images/clean-code.png"
			"/images/family.jpg"
			"/images/icon.png"
			"/images/twitter-bg.png"
			"/images/twitter-bg.png"
			"/images/fullweb-logo.svg"
		]

stashInCache = (cacheName, request, response) ->

	caches.open(cacheName).then (cache) ->

		cache.put request, response

# Limit the number of items in a specified cache.
trimCache = (cacheName, maxItems) ->

	caches.open(cacheName).then (cache) ->

		cache.keys().then (keys) ->

			if keys.length > maxItems

				cache.delete(keys[0]).then trimCache(cacheName, maxItems)

# Remove caches whose name is no longer valid
clearOldCaches = ->

	caches.keys().then (keys) ->

		Promise.all keys.filter (key) ->

			key.indexOf(version) != 0

		.map (key) ->

			caches.delete key

self.addEventListener "install", (event) ->

	event.waitUntil updateStaticCache().then ->

		self.skipWaiting()

self.addEventListener "activate", (event) ->

	event.waitUntil clearOldCaches().then ->

		self.clients.claim()

self.addEventListener "message", (event) ->

	if event.data.command == "trimCaches"
		trimCache pagesCacheName, 35
		trimCache imagesCacheName, 20

self.addEventListener "fetch", (event) ->

	request = event.request
	url = new URL request.url

	# Only deal with requests to my own server
	if url.origin != location.origin
		return

	# For non-GET requests, try the network first, fall back to the offline page
	if request.method != "GET"
		event.respondWith fetch(request).catch ->
			caches.match "/offline"

	# For HTML requests, try the network first, fall back to the cache, finally the offline page
	if request.headers.get("Accept").indexOf("text/html") != -1

		# Fix for Chrome bug: https://code.google.com/p/chromium/issues/detail?id=573937
		if request.mode != "navigate"
			request = new Request(url,
				method: "GET"
				headers: request.headers
				mode: request.mode
				credentials: request.credentials
				redirect: request.redirect)

		event.respondWith fetch(request).then (response) ->
			# NETWORK
			# Stash a copy of this page in the pages cache
			copy = response.clone()
			stashInCache pagesCacheName, request, copy
			response
		.catch ->
			# CACHE or FALLBACK
			caches.match(request).then (response) ->
				response or caches.match "/offline"

	# For non-HTML requests, look in the cache first, fall back to the network
	event.respondWith caches.match(request).then (response) ->
		# CACHE
		response or fetch(request).then (response) ->
			# NETWORK
			# If the request is for an image, stash a copy of this image in the images cache
			if request.headers.get("Accept").indexOf("image") != -1
				copy = response.clone()
				stashInCache imagesCacheName, request, copy
			response
		.catch ->
			# OFFLINE
			# If the request is for an image, show an offline placeholder
			if request.headers.get('Accept').indexOf('image') != -1
				return new Response "<svg role='img' aria-labelledby='offline-title' viewBox='0 0 400 300' xmlns='http://www.w3.org/2000/svg'><title id='offline-title'>Offline</title><g fill='none' fill-rule='evenodd'><path fill='#D8D8D8' d='M0 0h400v300H0z'/><text fill='#9B9B9B' font-family='Helvetica Neue,Arial,Helvetica,sans-serif' font-size='72' font-weight='bold'><tspan x='93' y='172'>offline</tspan></text></g></svg>", headers: "Content-Type": "image/svg+xml"