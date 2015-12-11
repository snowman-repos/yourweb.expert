React = require "react"

ReactComponent = React.createClass
	render: ->
		<div>Hello {this.props.name}!</div>

module.exports = ReactComponent