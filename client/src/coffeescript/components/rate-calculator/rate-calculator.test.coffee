describe "Rate Calculator", ->

	RateCalculator = require "./rate-calculator.coffee"
	RateCalculator.config = {}
	RateCalculator.el = {}

	beforeEach ->

		RateCalculator.config =
			baseRate: 3000
			currency: "usd"
			discountRate: 0.33333
			discountTime: 12
			rates:
				usd: 3000
				gbp: 2035
				eur: 2760
				cny: 19500
				jpy: 361500

		RateCalculator.el =
			slider:
				value: 1

	it "should format numbers", ->

		expect(RateCalculator.formatNumber(1)).toMatch "1"
		expect(RateCalculator.formatNumber(100)).toMatch "100"
		expect(RateCalculator.formatNumber(1000)).toMatch "1,000"
		expect(RateCalculator.formatNumber(10000)).toMatch "10,000"
		expect(RateCalculator.formatNumber(100000)).toMatch "100,000"
		expect(RateCalculator.formatNumber(1000000)).toMatch "1,000,000"

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