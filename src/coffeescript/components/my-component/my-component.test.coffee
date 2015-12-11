describe "My Component", ->

	myComponent = require "./my-component.coffee"

	it "should be defined", ->

		expect(myComponent).toBeDefined()

	it "should get something", ->

		expect(myComponent.getSomething()).toMatch "something"
