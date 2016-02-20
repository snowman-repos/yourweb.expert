###*
 * This class initiates the Service Worker, if
 * the user's browser supports Service Workers.
 * This is for providing offline, caching, and
 * other functionality where we can intercept
 * HTTP requests (e.g. intercept requests for
 * .webp files and replace them with .jpg if
 * .webp is not supported).
###
class ServiceWorker

	constructor: ->

		@initiateServicWorker()

	initiateServicWorker: ->

		if "serviceWorker" of navigator

			navigator.serviceWorker.register("/service-worker.js").then (registration) ->

				console.info "ServiceWorker registration successful with scope: ", registration.scope

			.catch (err) ->

				console.warn "ServiceWorker registration failed: ", err


module.exports = new ServiceWorker