api = require "../api/api.coffee"

###*
 * This class handles the rate calculator, getting
 * exchange rates for a select list of currencies and
 * determining my rates based on user input and
 * selected currency.
###
class RateCalculator

	constructor: ->

		@el =
			calculator: document.querySelector ".js-calculator"
			currencySelector: document.querySelector ".js-currency"
			currencySymbols: document.querySelectorAll ".js-currency-symbol"
			hourlyRate: document.querySelector ".js-hourly-rate"
			minRate: document.querySelector ".js-min-rate"
			slider: document.querySelector ".js-time-slider"
			sliderTime: document.querySelector ".js-time"
			sliderLabel: document.querySelector ".js-time-slider-text"
			sliderNotice: document.querySelector ".js-slider-notice"
			weeklyRate: document.querySelector ".js-rate"

		# Setup initial values
		@config =
			baseRate: 3000
			currency: "usd"
			discountRate: 0.33333 # This is how much discount I give for a project that's 12 weeks or longer
			discountTime: 12 # The limit on the number of project weeks after wich I continue to increase my discount
			rates: # Based on rates circa January 2016
				usd: 3000
				gbp: 2035
				eur: 2760
				cny: 19500
				jpy: 361500

		# Only run the code for this class if
		# the calculator is on the page
		if @el.calculator

			# set initial values because Firefox
			# always remembers input values from
			# previous sessions
			@el.slider.value = 1
			@el.currencySelector.value = "usd"

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

			@updateProjectLength @el.slider.value
			ga "send", "event", "slider", "slide", "project length change", @el.slider.value,
				nonInteraction: 1

		# When the user selects a different currency, the
		# rates should be recalculated for that currency
		@el.currencySelector.addEventListener "change", =>

			@updateCurrency @el.currencySelector.value
			ga "send", "event", "select", "selection", "currency change", @el.currencySelector.value,
				nonInteraction: 1

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

		@updateRateValues @calculateRates @config.currency

	###*
	 * Hide the notice beneath the slider.
	 * @return {Object} The DOM node for the slider notice element
	###
	hideNotice: ->

		if parseInt(@el.slider.value) < @config.discountTime
			@el.sliderNotice.classList.remove "is-shown"

	###*
	 * Set the currency symbol alongside any
	 * rate values.
	 * @param {String} symbol A reference to the symbol to be displayed
	###
	setSymbol: (symbol) ->

		for currencySymbol in @el.currencySymbols

			currencySymbol.textContent = symbol

	###*
	 * Show the notice beneath the slider.
	 * @return {Object} The DOM node for the slider notice element
	###
	showNotice: ->

		if @el.slider.value is @config.discountTime.toString()
			@el.sliderNotice.classList.add "is-shown"

	###*
	 * Update the selected currency, recalculate
	 * rates, and update the UI.
	 * @param  {String} currency The newly selected currency
	###
	updateCurrency: (currency) ->

		@config.currency = currency
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
	 * Update the selected project length, recalculate
	 * rates, and update the UI.
	 * @param  {Integer} weeks The project length in weeks
	###
	updateProjectLength: (weeks) ->

		# Display the selected number of weeks
		@el.sliderTime.textContent = weeks

		if weeks > 1
			@el.sliderLabel.textContent = "weeks"
		else
			@el.sliderLabel.textContent = "week"

		# Advise the user that there is a limit
		# to my discount by showing a notice
		if weeks is "12" then @showNotice() else @hideNotice()

		# Update the displayed rates
		@updateRateValues @calculateRates @config.currency

	###*
	 * Update the UI with the calculated rates.
	 * @param  {Object} rates The collection of rate values
	 * @return {Object}       The DOM node for the minimum rate element
	###
	updateRateValues: (rates) ->

		@el.hourlyRate.textContent = @formatNumber rates.hourly
		@el.minRate.textContent = @formatNumber rates.minimum
		@el.weeklyRate.textContent = @formatNumber rates.weekly


module.exports = new RateCalculator