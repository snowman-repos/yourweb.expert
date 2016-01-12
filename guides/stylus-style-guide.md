> Change as required

## Basic Syntax

**Tab indentation**

	// Bad
	.element
	  property value

	// Good
	.element
		property	value

**Remove all punctuation**

	// Bad
	.element {
		property: 	value;
	}

	// Good
	.element
		property	value

**Multiple selectors on new lines**

	// Bad
	.element1, element2
		property	value

	// Good
	.element1
	.element2
		property	value

**Use BEM naming convention: block__element--modifier**

	// Bad
	.className
	.class-name
	.class_name
	.classname
		property	value

	// Good
	.class__name
		property	value

**Always use double quotes**

	// Good
	a[href="http://example.com"]
		background	url("image.jpg")
		content		"link"

**NEVER use IDs as selectors**

	// Bad
	#element
		property	value

** List properties alphabetically**

	// Bad
	.element
		width		100px
		height		100px
		margin		100px

	// Good
	.element
		height		100px
		margin		100px
		width		100px

**Vertically align all properties**

	// Bad
	.element
		height 100px
		width 100px

	// Good
	.element
		height		100px
		width		100px

**Use namespace prefixes**

* o-		: objects
* c-		: components
* u-		: utilities
* t-		: themes
* s-		: scopes
* _ 		: hacks
* is-/has-	: states
* js-		: javascript-only
* qa-		: hook for QA testers

## Parent/Root Reference

**Use & to reference parent selectors**

	// Bad
	.element
		property	value

	.element:hover
		property	value

	.parent .element
		property	value

	.element + .element
		property	value

	// Good
	.element
		property		value

		&:hover
			property	value

		.parent &
			property	value

		& + &
			property	value

**Use the / root selector**

	// Bad
	.element
		property		value

	.is-active
		property		value

	// Good
	.element
		property		value

		/.is-active
			property	value

## Comments

Use // if you don't want comments to appear in compiled code, otherwise use /**/