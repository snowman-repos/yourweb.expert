> Change as required

## Basic Formatting

* Use the most minimal format style possible.
* Attributes should be comma separated.
* Attributes should be listed in alphabetical order.
* Elements with many attributes should use a multi-line format to avoid line-length getting too long.
* Classes should always precede any attributes.
* IDs should always be written as attributes to better differentiate from classes. This helps reinforce the fact that we shouldn't be using ids for styling purposes, only for anchor linking.
* Always use double quotes.
* Avoid writing any HTML within your Jade.
* Use the //- prefix for Jade comments as they are not compiled to HTML comments.

	.class__name(id="elementID", name="title", type="text", value="")

## Variable Formatting

* When a using a variable as the content of an element, always leave a space between the element and the variable.
* The #{variable} syntax is useful when mixing variables with strings, but isn’t needed when outputting variables on their own.

	a(href="link")= title
	h1= title
	h1 Welcome to #{title}.
	img(alt='A photo of the #{city} skyline.')

## Logic

* When using if, case, each etc., use the built-in Jade format (without leading hyphens).
* Use the built-in Jade each loop when iteration through a collection.
* Avoid duplicate code by using Mixins.

	if selected
		…
	else
		…

	each value, key in items
		…