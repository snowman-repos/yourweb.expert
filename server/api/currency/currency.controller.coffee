"use strict"

config = require "../../config/environment"
request = require "request"

exports.index = (req, res) ->

	url = "https://openexchangerates.org/api/latest.json?app_id=" + config.currency.clientID

	request url, (error, response, body) ->
		if !error and response.statusCode is 200
			allRates = JSON.parse body
			rates =
				USD: allRates.rates.USD
				CNY: allRates.rates.CNY
				EUR: allRates.rates.EUR
				GBP: allRates.rates.GBP
				JPY: allRates.rates.JPY
			res.jsonp rates
		else console.log error