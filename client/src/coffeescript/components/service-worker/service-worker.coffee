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