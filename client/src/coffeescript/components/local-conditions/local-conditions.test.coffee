jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Local Conditions", ->

	LocalConditions = require "./local-conditions.coffee"

	dummyData =
		condition: "0"
		temperature: 0

	beforeEach ->
		loadFixtures "home-page.html"

		LocalConditions.el.component = document.querySelector ".js-local-conditions"
		LocalConditions.el.icon = document.querySelector ".js-weather-icon"
		LocalConditions.el.temperature = document.querySelector ".js-temperature"
		LocalConditions.el.time = document.querySelector ".js-current-time"
		LocalConditions.el.weather = document.querySelector ".js-weather"

	it "should get the correct icon based on the time and weather conditions", ->

		expect(LocalConditions.getIcon(true, "113")).toMatch "clear--day"
		expect(LocalConditions.getIcon(false, "113")).toMatch "clear--night"
		expect(LocalConditions.getIcon(true, "116")).toMatch "cloudy--day"
		expect(LocalConditions.getIcon(false, "116")).toMatch "cloudy--night"
		expect(LocalConditions.getIcon(true, "119")).toMatch "cloudy--day"
		expect(LocalConditions.getIcon(false, "119")).toMatch "cloudy--night"
		expect(LocalConditions.getIcon(true, "260")).toMatch "foggy"
		expect(LocalConditions.getIcon(false, "260")).toMatch "foggy"
		expect(LocalConditions.getIcon(true, "248")).toMatch "foggy"
		expect(LocalConditions.getIcon(false, "248")).toMatch "foggy"
		expect(LocalConditions.getIcon(true, "143")).toMatch "foggy"
		expect(LocalConditions.getIcon(false, "143")).toMatch "foggy"
		expect(LocalConditions.getIcon(true, "122")).toMatch "overcast"
		expect(LocalConditions.getIcon(false, "122")).toMatch "overcast"
		expect(LocalConditions.getIcon(true, "200")).toMatch "lightening"
		expect(LocalConditions.getIcon(false, "200")).toMatch "lightening"
		expect(LocalConditions.getIcon(true, "386")).toMatch "lightening"
		expect(LocalConditions.getIcon(false, "386")).toMatch "lightening"
		expect(LocalConditions.getIcon(true, "176")).toMatch "light-rain"
		expect(LocalConditions.getIcon(false, "176")).toMatch "light-rain"
		expect(LocalConditions.getIcon(true, "293")).toMatch "light-rain"
		expect(LocalConditions.getIcon(false, "293")).toMatch "light-rain"
		expect(LocalConditions.getIcon(true, "263")).toMatch "light-rain"
		expect(LocalConditions.getIcon(false, "263")).toMatch "light-rain"
		expect(LocalConditions.getIcon(true, "266")).toMatch "light-rain"
		expect(LocalConditions.getIcon(false, "266")).toMatch "light-rain"
		expect(LocalConditions.getIcon(true, "296")).toMatch "light-rain"
		expect(LocalConditions.getIcon(false, "296")).toMatch "light-rain"
		expect(LocalConditions.getIcon(true, "353")).toMatch "light-rain"
		expect(LocalConditions.getIcon(false, "353")).toMatch "light-rain"
		expect(LocalConditions.getIcon(true, "389")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(false, "389")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(true, "359")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(false, "359")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(true, "308")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(false, "308")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(true, "305")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(false, "305")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(true, "302")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(false, "302")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(true, "299")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(false, "299")).toMatch "heavy-rain"
		expect(LocalConditions.getIcon(true, "371")).toMatch "light-snow"
		expect(LocalConditions.getIcon(false, "371")).toMatch "light-snow"
		expect(LocalConditions.getIcon(true, "368")).toMatch "light-snow"
		expect(LocalConditions.getIcon(false, "368")).toMatch "light-snow"
		expect(LocalConditions.getIcon(true, "338")).toMatch "light-snow"
		expect(LocalConditions.getIcon(false, "338")).toMatch "light-snow"
		expect(LocalConditions.getIcon(true, "335")).toMatch "light-snow"
		expect(LocalConditions.getIcon(false, "335")).toMatch "light-snow"
		expect(LocalConditions.getIcon(true, "332")).toMatch "light-snow"
		expect(LocalConditions.getIcon(false, "332")).toMatch "light-snow"
		expect(LocalConditions.getIcon(true, "329")).toMatch "light-snow"
		expect(LocalConditions.getIcon(false, "329")).toMatch "light-snow"
		expect(LocalConditions.getIcon(true, "326")).toMatch "light-snow"
		expect(LocalConditions.getIcon(false, "326")).toMatch "light-snow"
		expect(LocalConditions.getIcon(true, "323")).toMatch "light-snow"
		expect(LocalConditions.getIcon(false, "323")).toMatch "light-snow"
		expect(LocalConditions.getIcon(true, "230")).toMatch "light-snow"
		expect(LocalConditions.getIcon(false, "230")).toMatch "light-snow"
		expect(LocalConditions.getIcon(true, "227")).toMatch "light-snow"
		expect(LocalConditions.getIcon(false, "227")).toMatch "light-snow"
		expect(LocalConditions.getIcon(true, "179")).toMatch "light-snow"
		expect(LocalConditions.getIcon(false, "179")).toMatch "light-snow"
		expect(LocalConditions.getIcon(true, "395")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "395")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "392")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "392")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "377")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "377")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "374")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "374")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "365")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "365")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "362")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "362")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "350")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "350")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "320")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "320")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "317")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "317")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "314")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "314")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "311")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "311")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "284")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "284")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "281")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "281")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "182")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(false, "182")).toMatch "heavy-snow"
		expect(LocalConditions.getIcon(true, "test")).toMatch "clear--day"
		expect(LocalConditions.getIcon(false, "test")).toMatch "clear--night"

	it "should get the current time in Kunming", ->

		dateInKunming = new Date(new Date().getTime() + 8 * 3600 * 1000).toUTCString().replace( / GMT$/, "" )
		now = new Date(dateInKunming)
		hours = (if now.getHours() < 10 then "0" else "") + now.getHours()
		minutes = (if now.getMinutes() < 10 then "0" else "") + now.getMinutes()
		time = hours + ":" + minutes

		expect(LocalConditions.getTime()).toMatch time

	it "should handle incoming weather data", ->

		LocalConditions.handleData dummyData

		expect(LocalConditions.el.weather.classList).not.toContain "is-hidden"

	it "should run a clock showing local time", ->

		getTimeString = ->
			time = LocalConditions.getTime()
			hours = time.substr 0, 2
			minutes = time.substr -2, 2
			html = hours + "<span class='o-local-conditions__time__colon'>:</span>" + minutes

		LocalConditions.runClock()

		setTimeout ->

			expect(LocalConditions.el.time.innerHTML).toMatch getTimeString()

		, 1000

	it "should display the weather icon", ->

		hour = LocalConditions.getTime().substr 0,2
		isDaytime = if hour < 18 and hour >= 6 then true else false
		icon = LocalConditions.getIcon isDaytime, dummyData.condition

		LocalConditions.showCondition()

		expect(LocalConditions.el.icon.getAttribute("class")).toContain("o-icon--weather--" + icon)
		expect(LocalConditions.el.icon.querySelector("use").getAttribute("xlink:href")).toContain("#icon--" + icon)

	it "should display the temperature", ->

		LocalConditions.showTemperature dummyData.temperature

		expect(LocalConditions.el.temperature.textContent).toMatch dummyData.temperature.toString()