describe "Rate Calculator", ->

	RateCalculator = require "./rate-calculator.coffee"

	it "should format numbers", ->

		expect(RateCalculator.formatNumber(1)).toMatch "1"
		expect(RateCalculator.formatNumber(100)).toMatch "100"
		expect(RateCalculator.formatNumber(1000)).toMatch "1,000"
		expect(RateCalculator.formatNumber(10000)).toMatch "10,000"
		expect(RateCalculator.formatNumber(100000)).toMatch "100,000"
		expect(RateCalculator.formatNumber(1000000)).toMatch "1,000,000"