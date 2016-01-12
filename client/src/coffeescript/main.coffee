# Lovely welcome message
console.log "%c Welcome to YourWeb.Expert ", """
background: #243342;
color: #ffffcb;
font-size: 18px;
font-family: 'Helvetica Neue';
font-weight: 300;
line-height: 30px;
height: 30px;
padding: 5px
"""
console.log "%c darryl@yourweb.expert ", """
background: #243342;
color: #ffffcb;
font-size: 13px;
font-family: 'Helvetica Neue';
font-weight: 300;
line-height: 14px;
height: 30px;
padding: 5px 55px;
"""

window.config =
	blogURL: "http://api.tumblr.com/v2/blog/darryl-snow.tumblr.com/posts?type=text&limit=1&api_key=y3G70eslDUNZwHFiFg7PGLeaUAQwQ8O3KUXlpS413VkCxIc39q"
	exchangeRatesURL: "http://openexchangerates.org/api/latest.json?app_id=f812be7beaac4da8a3e70e81747cc512"
	weatherURL: "http://api.worldweatheronline.com/free/v1/weather.ashx?q=Kunming&format=json&num_of_days=1&key=0d9295b0a177f7fb49506749d45f6445a3a66725"

React = require "react"
ReactDOM = require "react-dom"

ReactComponent = require "./react-components/react-component.coffee"

MyApp = React.createClass
	render: ->
		<ReactComponent name="world" />

ReactDOM.render <MyApp />, document.querySelectorAll(".js-my-app")[0]

Blog = require "./components/blog/blog.coffee"
ErrorPage = require "./components/error-page/error-page.coffee"
FormValidation = require "./components/form-validation/form-validation.coffee"
FullHeightSections = require "./components/full-height-section/full-height-section.coffee"
LocalConditions = require "./components/local-conditions/local-conditions.coffee"
MorphButton = require "./components/morph-button/morph-button.coffee"
RateCalculator = require "./components/rate-calculator/rate-calculator.coffee"
ScrollWatcher = require "./components/scroll-watcher/scroll-watcher.coffee"
# ServiceWorker = require "./components/service-worker/service-worker.coffee"