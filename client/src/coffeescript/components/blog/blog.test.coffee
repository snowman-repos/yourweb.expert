# fetch = require "isomorphic-fetch"
# window.promise = Promise = require "promise-polyfill"
# Q = require "q"
# mockPromises = require "mock-promises"
#
# promise1 = null

describe "Blog", ->

	# API = require "../api/api.coffee"
	Blog = require "./blog.coffee"

	date = new Date()

	beforeEach ->
		usernameInput = document.createElement "input"

	# beforeEach ->
	#
	# 	mockPromises.install Q.makePromise
	# 	mockPromises.reset()
	# 	promise1 = Q
	# 		blog: "bleh"
	#
	# 	# spyOn(window, "fetch").and.callFake ->
	# 	# 	new Promise (resolve, reject) ->
	# 	# 		resolve
	# 	# 			blog: "bleh"

	it "gets the short name of the month", ->

		expect(Blog.getMonth(0)).toMatch "Jan"
		expect(Blog.getMonth(1)).toMatch "Feb"
		expect(Blog.getMonth(2)).toMatch "Mar"
		expect(Blog.getMonth(3)).toMatch "Apr"
		expect(Blog.getMonth(4)).toMatch "May"
		expect(Blog.getMonth(5)).toMatch "Jun"
		expect(Blog.getMonth(6)).toMatch "Jul"
		expect(Blog.getMonth(7)).toMatch "Aug"
		expect(Blog.getMonth(8)).toMatch "Sep"
		expect(Blog.getMonth(9)).toMatch "Oct"
		expect(Blog.getMonth(10)).toMatch "Nov"
		expect(Blog.getMonth(11)).toMatch "Dec"

	it "correctly format dates", ->

		expect(Blog.formatDate(new Date("Feb 19 2016"))).toMatch "19<sup>th</sup> Feb"
		expect(Blog.formatDate(new Date("Jan 1 2016"))).toMatch "1<sup>st</sup> Jan"
		expect(Blog.formatDate(new Date("Nov 3 2016"))).toMatch "3<sup>rd</sup> Nov"
		expect(Blog.formatDate(new Date("Nov 13 2016"))).toMatch "13<sup>th</sup> Nov"
		expect(Blog.formatDate(new Date("Jul 22 2016"))).toMatch "22<sup>nd</sup> Jul"
		expect(Blog.formatDate(new Date("Mar 5 2016"))).toMatch "5<sup>th</sup> Mar"

	it "gets the ordinal for a date", ->

		expect(Blog.getOrdinal(1)).toMatch "st"
		expect(Blog.getOrdinal(2)).toMatch "nd"
		expect(Blog.getOrdinal(3)).toMatch "rd"
		expect(Blog.getOrdinal(4)).toMatch "th"
		expect(Blog.getOrdinal(5)).toMatch "th"
		expect(Blog.getOrdinal(11)).toMatch "th"
		expect(Blog.getOrdinal(12)).toMatch "th"
		expect(Blog.getOrdinal(20)).toMatch "th"
		expect(Blog.getOrdinal(21)).toMatch "st"
		expect(Blog.getOrdinal(22)).toMatch "nd"
		expect(Blog.getOrdinal(23)).toMatch "rd"
		expect(Blog.getOrdinal(24)).toMatch "th"
		expect(Blog.getOrdinal(30)).toMatch "th"
		expect(Blog.getOrdinal(31)).toMatch "st"

	# it "gets data", ->
	#
	# 	data = Blog.test()
	# 	console.log data
	# 	expect(data).toMatch
	# 		blog: "test"

	# it "retrieves a list of articles", ->
	#
	# 	dfd = Q.defer()
	# 	promise = dfd.promise
	# 	spyOn(window, "fetch").and.callFake ->
	# 		promise
	#
	# 	dfd.resolve
	# 		blog: "bleh kjj"
	#
	# 	Blog.getArticles()
	# 	.then (response) ->
	# 		response.json()
	# 	.then (data) ->
	# 		expect(data).toEqual
	# 			blog: "bleh"
	#
	# 	# Q.when Blog.getArticles(), (response) ->
	# 	# 	console.log response
	# 	# 	expect(true).toBe true
	#
	# 	# articles = Blog.getArticles()
	# 	# .then (response) ->
	# 	# 	response.json()
	# 	# .then(data) ->
	# 	# 	expect(data).toEqual
	# 	# 		blog: "bleh"
	# 	# 	done()
	#
	# 	# promisedValue = null
	# 	#
	# 	# promise1.then (value) ->
	# 	# 	promisedValue = value
	# 	#
	# 	# promisedValue = "not foo"
	# 	#
	# 	# mockPromises.executeForPromise promise1
	# 	# expect(promisedValue).toEqual
	# 	# 	blog: "bleh"
	#
	# 	# ---
	#
	# 	# articles = Blog.getArticles()
	# 	# .then (response)->
	# 	# 	response.json()
	# 	# .then (data) =>
	# 	# 	console.log data
	# 	#
	# 	# 	expect(data).toEqual
	# 	# 		blog: "blehkbi"