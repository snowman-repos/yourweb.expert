# Lovely welcome message
console.log "%c Welcome to [Project] ", """
background: #25a8e0;
color: #ffffff;
font-size: 18px;
font-family: 'Helvetica Neue';
font-weight: 300;
line-height: 30px;
height: 30px;
padding: 5px
"""

# Non-react component
MyComponent = require "./components/my-component/my-component.coffee"

React = require "react"
ReactDOM = require "react-dom"

ReactComponent = require "./components/react-component/react-component.coffee"

MyApp = React.createClass
	render: ->
		<ReactComponent name="world" />

ReactDOM.render <MyApp />, document.querySelectorAll(".js-my-app")[0]