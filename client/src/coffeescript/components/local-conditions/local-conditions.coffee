api = require "../api/api.coffee"

###*
 * This class deals with the local conditions,
 * including current time and weather, in my
 * location (Kunming).
###
class LocalConditions

	constructor: ->

		@el =
			component: document.querySelector ".js-local-conditions"
			icon: document.querySelector ".js-weather-icon"
			temperature: document.querySelector ".js-temperature"
			time: document.querySelector ".js-current-time"
			weather: document.querySelector ".js-weather"

		# Only call these functions if the component
		#  is on the page
		if @el.component
			@runClock()
			@getWeather()

	###*
	 * Determine which icon to use based on the
	 * time of day and weather conditions.
	 * @param  {Boolean} isDaytime To determine if to show a day time or night time icon
	 * @param  {String} condition  A code returned by the Weatheronline API to indicate the current weather conditions
	 * @return {String}            A class suffix that indicates which icon should be displayed
	###
	getIcon: (isDaytime, condition) ->

		# take this out to a function
		switch condition
			when "113"
				if isDaytime
					icon = "clear--day"
				else
					icon = "clear--night"
			when "116"
				if isDaytime
					icon = "cloudy--day"
				else
					icon = "cloudy--night"
			when "119"
				if isDaytime
					icon = "cloudy--day"
				else
					icon = "cloudy--night"
			when "260" then icon = "foggy"
			when "248" then icon = "foggy"
			when "143" then icon = "foggy"
			when "122" then icon = "overcast"
			when "200" then icon = "lightening"
			when "386" then icon = "lightening"
			when "176" then icon = "light-rain"
			when "293" then icon = "light-rain"
			when "263" then icon = "light-rain"
			when "266" then icon = "light-rain"
			when "296" then icon = "light-rain"
			when "353" then icon = "light-rain"
			when "389" then icon = "heavy-rain"
			when "359" then icon = "heavy-rain"
			when "308" then icon = "heavy-rain"
			when "305" then icon = "heavy-rain"
			when "302" then icon = "heavy-rain"
			when "299" then icon = "heavy-rain"
			when "371" then icon = "light-snow"
			when "368" then icon = "light-snow"
			when "338" then icon = "light-snow"
			when "335" then icon = "light-snow"
			when "332" then icon = "light-snow"
			when "329" then icon = "light-snow"
			when "326" then icon = "light-snow"
			when "323" then icon = "light-snow"
			when "230" then icon = "light-snow"
			when "227" then icon = "light-snow"
			when "179" then icon = "light-snow"
			when "395" then icon = "heavy-snow"
			when "392" then icon = "heavy-snow"
			when "377" then icon = "heavy-snow"
			when "374" then icon = "heavy-snow"
			when "365" then icon = "heavy-snow"
			when "362" then icon = "heavy-snow"
			when "350" then icon = "heavy-snow"
			when "320" then icon = "heavy-snow"
			when "317" then icon = "heavy-snow"
			when "314" then icon = "heavy-snow"
			when "311" then icon = "heavy-snow"
			when "284" then icon = "heavy-snow"
			when "281" then icon = "heavy-snow"
			when "182" then icon = "heavy-snow"
			else
				if isDaytime
					icon = "clear--day"
				else
					icon = "clear--night"

		icon

	###*
	 * Get the current time in timezone UTC+8
	 * @return {String} The current time in hours:minutes
	###
	getTime: ->

		time = new Date(new Date().getTime() + (28800000)).toUTCString().replace(" GMT", "").substr -8
		time.substr(0, time.length - 3)

	###*
	 * Query the API to retrieve weather data.
	###
	getWeather: ->

		url = api.getURL "weather"

		fetch url
		.then (response) ->

			response.json()

		.then (data) =>

			@handleData data

		.catch (reason) =>

			# console.error reason

			# If we can't get the weather data then remove
			# the DOM node
			@el.weather.parentNode.removeChild @el.weather

	###*
	 * Process and display the weather information.
	 * @param  {Object} data Weather data as a JSON object returned by the API.
	 * @return {Object}      The DOM node for the weather component
	###
	handleData: (data) ->

		@showCondition data.condition
		@showTemperature data.temperature

		# Display the weather information
		@el.weather.classList.remove "is-hidden"

	###*
	 * Display a digital clock that shows the time
	 * in my current location (Kunming, GMT +8) and
	 * updates every second.
	###
	runClock: ->

		if @el.time

			setInterval =>

				time = @getTime()
				hours = time.substr 0, 2
				minutes = time.substr -2, 2

				@el.time.innerHTML = hours + "<span class='o-local-conditions__time__colon'>:</span>" + minutes

			, 1000

	###*
	 * Apply the appropriate class to the weather icon
	 * based on data returned by the API.
	 * @param  {String} condition  A code returned by the Weatheronline API that indicates the current weather conditions
	 * @return {Object}            The DOM node for the icon
	###
	showCondition: (condition) ->

		hour = @getTime().substr 0,2
		isDaytime = if hour < 18 and hour >= 6 then true else false

		icon = @getIcon isDaytime, condition

		if @el.icon

			# take this out to a function
			# (we're not using classList because of sketchy
			# support when used on SVGs)
			# @el.icon.classList.add "o-icon--weather--" + icon
			@el.icon.setAttribute "class", @el.icon.getAttribute("class") + " o-icon--weather--" + icon
			@el.icon.querySelector("use").setAttribute "xlink:href", "#icon--" + icon

	###*
	 * Insert the current temperature into the DOM node.
	 * @param  {Integer} temperature The temperature
	 * @return {Object}              The DOM node for the temperature element
	###
	showTemperature: (temperature) ->

		if @el.temperature then @el.temperature.textContent = temperature


module.exports = new LocalConditions