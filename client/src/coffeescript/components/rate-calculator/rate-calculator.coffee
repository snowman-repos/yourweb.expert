api = require "../api/api.coffee"

###*
 * This class handles the rate calculator, getting
 * exchange rates for a select list of currencies and
 * determining my rates based on user input and
 * selected currency.
###
class RateCalculator

	constructor: ->

		calculator = document.querySelector ".js-calculator"

		# Only run the code for this class if
		# the calculator is on the page
		if calculator

			@el =
				currencySelector: calculator.querySelector ".js-currency"
				currencySymbols: calculator.querySelectorAll ".js-currency-symbol"
				hourlyRate: calculator.querySelector ".js-hourly-rate"
				minRate: calculator.querySelector ".js-min-rate"
				slider: calculator.querySelector ".js-time-slider"
				sliderTime: calculator.querySelector ".js-time"
				sliderLabel: calculator.querySelector ".js-time-slider-text"
				sliderNotice: calculator.querySelector ".js-slider-notice"
				weeklyRate: calculator.querySelector ".js-rate"

			# Setup initial values
			@config =
				baseRate: 3000
				currency: "usd"
				discountRate: 0.33333 # This is how much discount I give for a project that's 12 weeks or longer
				discountTime: 12 # The limit on the number of project weeks after wich I continue to increase my discount
				rates: {} # This will contain the latest exchange rate data

			@getRates()
			@addEventListeners()

	###*
	 * Attach event listeners to the currency selector
	 * and the project length slider.
	###
	addEventListeners: ->

		# When the user slides the project length slider
		# the rates should be recalculated and the various
		# labels updated
		@el.slider.addEventListener "input", =>

			weeks = @el.slider.value

			# Display the selected number of weeks
			@el.sliderTime.innerText = weeks

			if weeks > 1 then @el.sliderLabel.innerText = "weeks"

			# Advise the user that there is a limit
			# to my discount by showing a notice
			if weeks is "12" then @showNotice() else @hideNotice()

			# Update the displayed rates
			@updateRateValues @calculateRates @config.currency

		# When the user selects a different currency, the
		# rates should be recalculated for that currency
		@el.currencySelector.addEventListener "change", =>

			@config.currency = @el.currencySelector.value
			@updateRateValues @calculateRates @config.currency

			# We also need to update the currency symbols
			# displayed alongside any rates
			switch @config.currency
				when "usd" then @setSymbol "$"
				when "gbp" then @setSymbol "£"
				when "eur" then @setSymbol "€"
				when "cny" then @setSymbol "¥"
				when "jpy" then @setSymbol "¥"

	###*
	 * Calculate my hourly, weekly, and minimum rates
	 * in the selected currency, based on the length
	 * of the project.
	 * @param  {String} currency The selected currency
	 * @return {Object}          The collection of rate values
	###
	calculateRates: (currency) ->

		rate = @config.rates[currency]
		discount = (rate * @config.discountRate) / (@config.discountTime - 1)

		rates =
			hourly: Math.floor((rate - (discount * (@el.slider.value - 1))) / 40)
			minimum: Math.floor(rate - (discount * (@config.discountTime - 1)))
			weekly: Math.floor(rate - (discount * (@el.slider.value - 1)))

	###*
	 * Format a number to be more easily readable,
	 * i.e. 1000 -> 1,000
	 * @param  {Integer} number The number to be formatted
	 * @return {String}         The formatted number to be displayed
	###
	formatNumber: (number) ->

		number.toString().replace /\B(?=(\d{3})+(?!\d))/g, ","

	###*
	 * Query the Openexchange API to get the latest
	 * exchange rates.
	###
	getRates: ->

		url = api.getURL "currency"

		fetch url
		.then (response) ->

			response.json()

		.then (data) =>

			@handleData data

		.catch (reason) =>

			@handleFailure()

	###*
	 * Update my rates based on the latest
	 * exchange rate data.
	###
	handleData: (data) ->

		@config.rates =
			usd: @config.baseRate
			gbp: Math.ceil data.GBP * @config.baseRate
			eur: Math.ceil data.EUR * @config.baseRate
			cny: Math.ceil data.CNY * @config.baseRate
			jpy: Math.ceil data.JPY * @config.baseRate

		@updateRateValues @calculateRates @config.currency

	###*
	 * If exchange rate data can't be retrieved
	 * then just use some dummy data for my rates;
	 * after all the rates are only a rough guide.
	###
	handleFailure: ->

		console.error "Failed to get exchange rates"

		# Based on rates circa January 2016
		@config.rates =
			usd: @config.baseRate
			gbp: 2035
			eur: 2760
			cny: 19500
			jpy: 361500

		@updateRateValues @calculateRates @config.currency

	###*
	 * Hide the notice beneath the slider.
	 * @return {Object} The DOM node for the slider notice element
	###
	hideNotice: ->

		@el.sliderNotice.classList.remove "is-shown"

	###*
	 * Set the currency symbol alongside any
	 * rate values.
	 * @param {String} symbol A reference to the symbol to be displayed
	###
	setSymbol: (symbol) ->

		for currencySymbol in @el.currencySymbols

			currencySymbol.innerText = symbol

	###*
	 * Show the notice beneath the slider.
	 * @return {Object} The DOM node for the slider notice element
	###
	showNotice: ->

		@el.sliderNotice.classList.add "is-shown"

	###*
	 * Update the UI with the calculated rates.
	 * @param  {Object} rates The collection of rate values
	 * @return {Object}       The DOM node for the minimum rate element
	###
	updateRateValues: (rates) ->

		@el.hourlyRate.innerText = @formatNumber rates.hourly
		@el.minRate.innerText = @formatNumber rates.minimum
		@el.weeklyRate.innerText = @formatNumber rates.weekly


module.exports = new RateCalculator