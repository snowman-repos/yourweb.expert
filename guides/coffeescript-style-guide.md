> Change as required

* UTF-8 is the preferred source file encoding.
* Tabs for indentation. Never mix tabs and spaces.
* Maximum line length: 80chars.
* Object keys should be listed on new lines in alphabetical order.
* Separate top-level function and class definitions with a single blank line.
* Separate method definitions inside of a class with a single blank line.
* Use a single blank line within the bodies of methods or functions in cases where this improves readability (e.g., for the purpose of delineating logical sections).
* Use a single blank line immediately after function definitions.
* Use double blank lines immediately following a class block.
* Do not include trailing whitespace on any lines.
* Always avoid commas wherever possible.
* Always avoid any brackets wherever possible (i.e. not in cases where method calls are being chained).
* require statements should be placed on separate lines.
* require statements should be in alphabetical order.

	require "A"
	require "B"

	class MyClass

		constructor: ->

			myArray = [
				key1: "value"
				key2: "value"
			]

			objectArray = [
				key1: "value"
				key2: "value"
			,
				key1: "value"
				key2: "value"
			]


	module.exports = new MyClass

* Avoid extraneous whitespace:

	// Bad
	( $ "body" )
	console.log x , y

	// Good
	($ "body")
	console.log x, y

* Always surround these binary operators with a single space on either side.
* The first word of the comment should be capitalised, unless the first word is an identifier that begins with a lower-case letter.
* Use camelCase (with a leading lowercase character) to name all variables, methods, and object properties.
* Use CamelCase (with a leading uppercase character) to name all classes.
* For constants, use all uppercase with underscores.
* Methods and variables that are intended to be "private" should begin with a leading underscore.
* When declaring a function that takes arguments, always use a single space after the closing parenthesis of the arguments list.
* Do not use parentheses when declaring functions that take no arguments.
* In cases where method calls are being chained and the code does not fit on a single line, each call should be placed on a separate line and indented by one level (i.e., one tab), with a leading .:

	[1..3]
		.map (x) -> x * x
		.concat [10..12]
		.filter (x) -> x < 11
		.reduce (x, y) -> x + y

* Functions within classes should be grouped by private and public, then listed alphabetically.
* Use string interpolation instead of string concatenation:

	"this is an #{adjective} string" # Yes
	"this is an " + adjective + " string" # No

* Prefer double quoted strings ("") instead of single quoted ('') strings, unless features like string interpolation are being used for the given string.
* Favor unless over if for negative conditions.
* Multi-line if/else clauses should use indentation.
* Take advantage of comprehensions whenever possible:

	# Yes
	result = (item.name for item in array)

	# No
	results = []
	for item in array
		results.push item.name

* To filter:

	result = (item for item in array when item.name is "test")

* To iterate over the keys and values of objects:

	object =
		one: 1
		two: 2
	alert "#{key} = #{value}" for key, value of object

* Do not modify native objects.
* Use annotations when necessary to describe a specific action that must be taken against the indicated block of code:

	* TODO: describe missing functionality that should be added at a later date
	* FIXME: describe broken code that must be fixed
	* OPTIMIZE: describe code that is inefficient and may become a bottleneck
	* HACK: describe the use of a questionable (or ingenious) coding practice
	* REVIEW: describe code that should be reviewed to confirm implementation

* and is preferred over &&.
* or is preferred over ||.
* is is preferred over ==.
* isnt is preferred over !=.
* not is preferred over !.
* or= should be used when possible:

	temp or= {} # Yes
	temp = temp || {} # No

* Prefer shorthand notation (::) for accessing an object's prototype:

	Array::slice # Yes
	Array.prototype.slice # No

* Prefer @property over this.property.
* However, avoid the use of standalone @.
* Avoid return where not required, unless the explicit return increases clarity.
* Use splats (...) when working with functions that accept variable numbers of arguments:

	console.log args... # Yes
	(a, b, c, rest...) -> # Yes