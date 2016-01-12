# "use strict"
# console.info "WORKER: executing."
#
# version = "v1::"
#
# offlineFundamentals = [
# 	""
# 	"styles/main.min.css"
# 	"scripts/main.min.js"
# 	"images/icon.png"
# 	"images/darryl-snow.jpg"
# 	"images/darryl-snow.webp"
# 	"images/fullweb-logo.svg"
# ]
#
# self.addEventListener "install", (event) ->
#
# 	console.info "WORKER: install event in progress."
#
# 	event.waitUntil caches.open(version + "fundamentals").then (cache) ->
#
# 		cache.addAll offlineFundamentals
#
# 	.then ->
#
# 		console.info "WORKER: install completed"
#
# self.addEventListener "fetch", (event) ->
#
# 	console.info "WORKER: fetch event in progress."
#
# 	if event.request.method isnt "GET"
#
# 		console.info "WORKER: fetch event ignored.", event.request.method, event.request.url
#
# 	if /\.jpg$|.png$/.test event.request.url
#
# 		supportsWebp = false
#
# 		if event.request.headers.has "accept"
#
# 			supportsWebp = event.request.headers.get("accept").includes "webp"
#
# 		console.log supportsWebp
#
# 		if supportsWebp
#
# 			req = event.request.clone()
#
# 			returnUrl = req.url.substr(0, req.url.lastIndexOf(".")) + ".webp"
#
# 			event.respondWith fetch returnUrl,
# 				mode: "no-cors"
#
# 	event.respondWith caches.match(event.request).then (cached) ->
#
# 		networked = fetch(event.request).then(fetchedFromNetwork, unableToResolve).catch(unableToResolve)
#
# 		fetchedFromNetwork = (response) ->
#
# 			cacheCopy = response.clone()
#
# 			console.info "WORKER: fetch response from network.", event.request.url
#
# 			caches.open(version + "pages").then (cache) ->
#
# 				cache.put event.request, cacheCopy
#
# 			.then ->
#
# 				console.info "WORKER: fetch response stored in cache.", event.request.url
#
# 			response
#
# 		unableToResolve = ->
#
# 			console.info "WORKER: fetch request failed in both cache and network."
#
# 			new Response("<h1>Service Unavailable</h1>",
# 				status: 503
# 				statusText: "Service Unavailable"
# 				headers: new Headers "Content-Type": "text/html")
#
# 		if cached
#
# 			console.info "WORKER: fetch event (cached)", event.request.url
#
# 		else
#
# 			console.info "WORKER: fetch event (networked)", event.request.url
#
# self.addEventListener "activate", (event) ->
#
# 	console.info "WORKER: activate event in progress."
#
# 	event.waitUntil caches.keys().then (keys) ->
#
# 		Promise.all keys.filter (key) ->
#
# 			!key.startsWith(version)
#
# 		.map (key) ->
#
# 			caches.delete key
#
# 	.then ->
#
# 		console.info "WORKER: activate completed."