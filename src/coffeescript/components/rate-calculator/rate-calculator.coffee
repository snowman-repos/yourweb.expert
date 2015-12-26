class RateCalculator

	constructor: (el) ->

		@el =
			currencySelecor: el.querySelector ".js-currency"
			currencySymbols: el.querySelectorAll ".js-currency-symbol"
			hourlyRate: el.querySelector ".js-hourly-rate"
			minRate: el.querySelector ".js-min-rate"
			slider: el.querySelector ".js-time-slider"
			sliderTime: el.querySelector ".js-time"
			sliderLabel: el.querySelector ".js-time-slider-text"
			sliderNotice: el.querySelector ".js-slider-notice"
			weeklyRate: el.querySelector ".js-rate"

		@config =
			baseRate: 3000
			currency: "usd"
			discountRate: 1200 / 11
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

		# weekly rate
		rate = Math.ceil(@config.rate - (@config.discountRate * (@el.slider.value - 1)))
		@el.weeklyRate.innerText = @formatNumber rate

		# hourly rate
		weeklyRate = Math.ceil rate / 40
		@el.hourlyRate.innerText = @formatNumber weeklyRate

		# minimum rate
		minimumRate = Math.ceil(@config.rate - (@config.discountRate * 11))
		@el.minRate.innerText = @formatNumber minimumRate

	formatNumber: (number) ->

		number.toString().replace /\B(?=(\d{3})+(?!\d))/g, ","

	getRates: ->

		# lookup from xe.com
		fetch "http://openexchangerates.org/api/latest.json?app_id=f812be7beaac4da8a3e70e81747cc512"
		.then (response) ->
			response.json()
		.then (data) =>

			rates = data.rates

			@config.rates =
				usd: @config.baseRate
				gbp: Math.ceil rates.GBP * @config.baseRate
				eur: Math.ceil rates.EUR * @config.baseRate
				cny: Math.ceil rates.CNY * @config.baseRate
				jpy: Math.ceil rates.JPY * @config.baseRate

			@calculateRates @config.currency

	hideNotice: ->

		@el.sliderNotice.classList.remove "is-shown"

	setSymbol: (symbol) ->

		for currencySymbol in @el.currencySymbols

			currencySymbol.innerText = symbol

	showNotice: ->

		@el.sliderNotice.classList.add "is-shown"


module.exports = do ->

	calculator = document.querySelector ".js-calculator"

	if calculator then new RateCalculator calculator