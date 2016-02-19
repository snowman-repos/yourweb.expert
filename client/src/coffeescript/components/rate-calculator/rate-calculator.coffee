api = require "../api/api.coffee"

class RateCalculator

	constructor: ->

		calculator = document.querySelector ".js-calculator"

		if calculator

			@el =
				currencySelecor: calculator.querySelector ".js-currency"
				currencySymbols: calculator.querySelectorAll ".js-currency-symbol"
				hourlyRate: calculator.querySelector ".js-hourly-rate"
				minRate: calculator.querySelector ".js-min-rate"
				slider: calculator.querySelector ".js-time-slider"
				sliderTime: calculator.querySelector ".js-time"
				sliderLabel: calculator.querySelector ".js-time-slider-text"
				sliderNotice: calculator.querySelector ".js-slider-notice"
				weeklyRate: calculator.querySelector ".js-rate"

			@config =
				baseRate: 3000
				currency: "usd"
				discountRate: 0.33333
				discountTime: 12
				rate: 3000
				rates: {}

			@getRates()
			@addEventListeners()

	addEventListeners: ->

		@el.slider.addEventListener "input", =>

			weeks = @el.slider.value

			@el.sliderTime.innerText = weeks

			if weeks > 1 then @el.sliderLabel.innerText = "weeks"

			if weeks is "12" then @showNotice() else @hideNotice()

			@calculateRates @config.currency

		@el.currencySelecor.addEventListener "change", =>

			@config.currency = @el.currencySelecor.value
			@calculateRates @config.currency

			switch @config.currency
				when "usd" then @setSymbol "$"
				when "gbp" then @setSymbol "£"
				when "eur" then @setSymbol "€"
				when "cny" then @setSymbol "¥"
				when "jpy" then @setSymbol "¥"

	calculateRates: (currency) ->

		@config.rate = @config.rates[currency]
		discount = (@config.rate * @config.discountRate) / (@config.discountTime - 1)

		# weekly rate
		rate = Math.floor(@config.rate - (discount * (@el.slider.value - 1)))
		@el.weeklyRate.innerText = @formatNumber rate

		# hourly rate
		weeklyRate = Math.floor rate / 40
		@el.hourlyRate.innerText = @formatNumber weeklyRate

		# minimum rate
		minimumRate = Math.floor(@config.rate - (discount * (@config.discountTime - 1)))
		@el.minRate.innerText = @formatNumber minimumRate

	formatNumber: (number) ->

		number.toString().replace /\B(?=(\d{3})+(?!\d))/g, ","

	getRates: ->

		url = api.getURL "currency"

		fetch url
		.then (response) ->

			response.json()

		.then (data) =>

			@config.rates =
				usd: @config.baseRate
				gbp: Math.ceil data.GBP * @config.baseRate
				eur: Math.ceil data.EUR * @config.baseRate
				cny: Math.ceil data.CNY * @config.baseRate
				jpy: Math.ceil data.JPY * @config.baseRate

			@calculateRates @config.currency

		.catch (reason) =>

			# console.error reason

			# data fetch failed so just use rough defaults
			@config.rates =
				usd: @config.baseRate
				gbp: 2035
				eur: 2760
				cny: 19500
				jpy: 361500

			@calculateRates @config.currency

	hideNotice: ->

		@el.sliderNotice.classList.remove "is-shown"

	setSymbol: (symbol) ->

		for currencySymbol in @el.currencySymbols

			currencySymbol.innerText = symbol

	showNotice: ->

		@el.sliderNotice.classList.add "is-shown"


module.exports = new RateCalculator