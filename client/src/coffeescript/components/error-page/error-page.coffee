###*
 * This class is used when the error page is loaded.
 * (Currently not used but when I get to making a fancy
 * error page I imagine there will be some JS involved...).
###
class ErrorPage

	constructor: ->

		errorPage = document.querySelector ".js-error-page"

		if errorPage then console.info "error page"


module.exports = new ErrorPage