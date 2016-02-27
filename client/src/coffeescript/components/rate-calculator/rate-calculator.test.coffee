jasmine.getFixtures().fixturesPath = "base/client/src/coffeescript/fixtures"

describe "Rate Calculator", ->

	RateCalculator = require "./rate-calculator.coffee"

	beforeEach ->

		window.ga = ->

		loadFixtures "home-page.html"

		RateCalculator.el.currencySelector = document.querySelector ".js-currency"
		RateCalculator.el.currencySymbols = document.querySelectorAll ".js-currency-symbol"
		RateCalculator.el.hourlyRate = document.querySelector ".js-hourly-rate"
		RateCalculator.el.minRate = document.querySelector ".js-min-rate"
		RateCalculator.el.slider = document.querySelector ".js-time-slider"
		RateCalculator.el.sliderTime = document.querySelector ".js-time"
		RateCalculator.el.sliderLabel = document.querySelector ".js-time-slider-text"
		RateCalculator.el.sliderNotice = document.querySelector ".js-slider-notice"
		RateCalculator.el.weeklyRate = document.querySelector ".js-rate"

	it "should calculate my rates", ->

		# 1 week
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 75
			minimum: 2000
			weekly: 3000

		expect(RateCalculator.calculateRates("gbp")).toEqual
			hourly: 50
			minimum: 1356
			weekly: 2035

		expect(RateCalculator.calculateRates("eur")).toEqual
			hourly: 69
			minimum: 1840
			weekly: 2760

		expect(RateCalculator.calculateRates("cny")).toEqual
			hourly: 487
			minimum: 13000
			weekly: 19500

		expect(RateCalculator.calculateRates("jpy")).toEqual
			hourly: 9037
			minimum: 241001
			weekly: 361500

		# 2 weeks
		RateCalculator.el.slider.value = 2
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 72
			minimum: 2000
			weekly: 2909

		# 3 weeks
		RateCalculator.el.slider.value = 3
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 70
			minimum: 2000
			weekly: 2818

		# 4 weeks
		RateCalculator.el.slider.value = 4
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 68
			minimum: 2000
			weekly: 2727

		# 5 weeks
		RateCalculator.el.slider.value = 5
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 65
			minimum: 2000
			weekly: 2636

		# 6 weeks
		RateCalculator.el.slider.value = 6
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 63
			minimum: 2000
			weekly: 2545

		# 7 weeks
		RateCalculator.el.slider.value = 7
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 61
			minimum: 2000
			weekly: 2454

		# 8 weeks
		RateCalculator.el.slider.value = 8
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 59
			minimum: 2000
			weekly: 2363

		# 9 weeks
		RateCalculator.el.slider.value = 9
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 56
			minimum: 2000
			weekly: 2272

		# 10 weeks
		RateCalculator.el.slider.value = 10
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 54
			minimum: 2000
			weekly: 2181

		# 11 weeks
		RateCalculator.el.slider.value = 11
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 52
			minimum: 2000
			weekly: 2090

		# 12 weeks
		RateCalculator.el.slider.value = 12
		expect(RateCalculator.calculateRates("usd")).toEqual
			hourly: 50
			minimum: 2000
			weekly: 2000

	it "should format numbers", ->

		expect(RateCalculator.formatNumber(1)).toMatch "1"
		expect(RateCalculator.formatNumber(100)).toMatch "100"
		expect(RateCalculator.formatNumber(1000)).toMatch "1,000"
		expect(RateCalculator.formatNumber(10000)).toMatch "10,000"
		expect(RateCalculator.formatNumber(100000)).toMatch "100,000"
		expect(RateCalculator.formatNumber(1000000)).toMatch "1,000,000"

	it "should handle incoming exchange rate data", ->

		dummyData =
			GBP: 1
			EUR: 2
			CNY: 3
			JPY: 4

		RateCalculator.handleData dummyData

		expect(RateCalculator.config.rates).toEqual
			usd: RateCalculator.config.baseRate
			gbp: RateCalculator.config.baseRate * 1
			eur: RateCalculator.config.baseRate * 2
			cny: RateCalculator.config.baseRate * 3
			jpy: RateCalculator.config.baseRate * 4

	it "hides the notice beneath the slider", ->

		RateCalculator.el.sliderNotice.classList.add "is-shown"

		RateCalculator.hideNotice()

		expect(RateCalculator.el.sliderNotice.classList).not.toContain "is-shown"

	it "sets the currency symbol", ->

		for currencySymbol in RateCalculator.el.currencySymbols

			currencySymbol.textContent = ""

		RateCalculator.setSymbol "¥"

		for currencySymbol in RateCalculator.el.currencySymbols

			expect(currencySymbol.textContent).toMatch "¥"

	it "displays the notice beneath the slider when the maximum value has been reached", ->

		RateCalculator.el.slider.value = 12
		RateCalculator.el.sliderNotice.classList.remove "is-shown"
		RateCalculator.showNotice()

		expect(RateCalculator.el.sliderNotice.classList).toContain "is-shown"

	it "updates the selected currency", ->

		RateCalculator.config.currency = ""
		RateCalculator.updateCurrency "cny"

		expect(RateCalculator.config.currency).toMatch "cny"

	it "updates the selected project length", ->

		# Display the selected number of weeks
		RateCalculator.el.sliderTime.textContent = ""
		RateCalculator.el.sliderNotice.classList.add "is-shown"

		RateCalculator.el.slider.value = 1
		RateCalculator.updateProjectLength "1"

		expect(RateCalculator.el.sliderTime.textContent).toMatch "1"
		expect(RateCalculator.el.sliderLabel.textContent).toMatch "week"
		expect(RateCalculator.el.sliderNotice.classList).not.toContain "is-shown"

		RateCalculator.el.slider.value = 5
		RateCalculator.updateProjectLength "5"

		expect(RateCalculator.el.sliderTime.textContent).toMatch "5"
		expect(RateCalculator.el.sliderLabel.textContent).toMatch "weeks"
		expect(RateCalculator.el.sliderNotice.classList).not.toContain "is-shown"

		RateCalculator.el.slider.value = 12
		RateCalculator.updateProjectLength "12"

		expect(RateCalculator.el.sliderTime.textContent).toMatch "12"
		expect(RateCalculator.el.sliderLabel.textContent).toMatch "weeks"
		expect(RateCalculator.el.sliderNotice.classList).toContain "is-shown"

	it "updates the UI with the calculated rates", ->

		RateCalculator.el.hourlyRate.textContent = ""
		RateCalculator.el.minRate.textContent = ""
		RateCalculator.el.weeklyRate.textContent = ""

		rates =
			hourly: 1
			minimum: 2
			weekly: 3

		RateCalculator.updateRateValues rates

		expect(RateCalculator.el.hourlyRate.textContent).toMatch "1"
		expect(RateCalculator.el.minRate.textContent).toMatch "2"
		expect(RateCalculator.el.weeklyRate.textContent).toMatch "3"