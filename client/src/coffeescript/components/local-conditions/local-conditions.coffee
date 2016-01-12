class LocalConditions

	constructor: ->

		@el =
			icon: document.querySelector ".js-weather-icon"
			temperature: document.querySelector ".js-temperature"
			time: document.querySelector ".js-current-time"
			weather: document.querySelector ".js-weather"

		@getTime()
		@runClock()
		@getWeather()

	getTime: ->

		time = new Date( new Date().getTime() + (28800000)).toUTCString().replace(" GMT", "").substr -8
		@time = time.substr(0, time.length - 3)

	getWeather: ->

		fetch window.config.weatherURL
		.then (response) ->

			response.json()

		.then (data) =>

			weather =
				condition: data.data.current_condition[0].weatherCode
				temperature: data.data.current_condition[0].temp_C

			if @el.temperature then @el.temperature.innerText = weather.temperature

			hour = @time.substr 0,2
			isDaytime = if hour < 18 and hour >= 6 then true else false

			switch weather.condition
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

			if @el.icon

				@el.icon.classList.add "o-icon--weather--" + icon
				@el.icon.querySelector("use").setAttribute "xlink:href", "#icon--" + icon

			@el.weather.classList.remove "is-hidden"

		.catch (reason) =>

			console.error reason

			@el.weather.parentNode.removeChild @el.weather

	runClock: ->

		if @el.time

			setInterval =>

				time = @getTime()
				hours = time.substr 0, 2
				minutes = time.substr -2, 2

				@el.time.innerHTML = hours + "<span class='c-contact__info__city__time__colon'>:</span>" + minutes

			, 1000


module.exports = new LocalConditions