React = require "react"
TestUtils = require "react-addons-test-utils"

describe "React Component", ->

	ReactComponent = require "./react-component.coffee"

	it "should be defined", ->

		expect(ReactComponent).toBeDefined()

	it "should work", ->

		reactComponent = <ReactComponent name="world" />
		TestUtils.renderIntoDocument reactComponent
		expect(reactComponent).toBeTruthy()
