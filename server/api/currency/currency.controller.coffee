"use strict"

config = require "../../config/environment"
request = require "request"

exports.index = (req, res) ->

	url = "https://openexchangerates.org/api/latest.json?app_id=" + config.currency.clientID

	request url, (error, response, body) ->
		if !error and response.statusCode is 200
			allRates = JSON.parse body
			rates =
				USD: Math.ceil allRates.rates.USD
				CNY: Math.ceil allRates.rates.CNY
				EUR: Math.ceil allRates.rates.EUR
				GBP: Math.ceil allRates.rates.GBP
				JPY: Math.ceil allRates.rates.JPY
			res.jsonp rates
		else console.log error