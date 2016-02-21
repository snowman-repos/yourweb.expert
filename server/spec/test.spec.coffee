request = require "request"
pkg = require "../../package.json"

baseURL = "http://localhost:8000"
apiURL = "http://localhost:8000/api/" + pkg.version

isJSON = (str) ->
	try
		JSON.parse str
	catch e
		return false
	true

describe "The server-side app", ->

	describe "GET /", ->

		it "returns a 200 status code for the index route", (done) ->

			request.get baseURL, (err, response, body) ->

				expect(response.statusCode).toBe 200
				expect(response.body).toContain "<title>Darryl Snow - Your Web Expert</title>"
				expect(typeof response.body).toBe "string"
				done()

		it "returns a 200 status code for any random route", (done) ->

			request.get baseURL + "/random", (err, response, body) ->

				expect(response.statusCode).toBe 200
				expect(response.body).toContain "<title>Darryl Snow - Your Web Expert</title>"
				expect(typeof response.body).toBe "string"
				done()

		it "returns a 200 status code for the blog API route", (done) ->

			request.get apiURL + "/blog", (err, response, body) ->

				expect(response.statusCode).toBe 200
				expect(isJSON response.body).toBe true
				done()

		it "returns a 200 status code for the currency API route", (done) ->

			request.get apiURL + "/currency", (err, response, body) ->

				expect(response.statusCode).toBe 200
				expect(isJSON response.body).toBe true
				done()

		it "returns a 200 status code for the weather API route", (done) ->

			request.get apiURL + "/weather", (err, response, body) ->

				expect(response.statusCode).toBe 200
				expect(isJSON response.body).toBe true
				done()

		it "can send emails", (done) ->

			request.post apiURL + "/email",
				senderName: "Jasmine-Node"
				senderEmail: "jasemine@node.com"
				message: "This is a spec runner"
			, (err, response, body) ->

				expect(response.statusCode).toBe 200
				expect(isJSON response.body).toBe true
				done()