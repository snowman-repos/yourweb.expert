pkg = require "../../../../../package.json"

describe "API", ->

	API = require "./api.coffee"

	it "should get the correct URL", ->

		url = API.getURL "test"

		if API.env is "development"

			expect(url).toMatch "http://localhost:8000/api/" + pkg.version + "/test"

		if API.env is "production"

			expect(url).toMatch pkg.homepage + "/api/" + pkg.version + "/test"