"use strict"

pkg	= require "../package.json"

module.exports =
	description: pkg.description
	env: "dev"
	keywords: pkg.keywords
	libs: [] #put here the filenames of any 3rd party libraries, e.g. "bootstrap/dist/css/bootstrap.css"
	livereloadPort: 35729
	names:
		css:
			compiled: "main.css"
			minified: "main.min.css"
			source: "main.styl"
		html:
			compiled: "index.html"
			source: "index.jade"
		js:
			compiled: "main.js"
			minified: "main.min.js"
			source: "main.coffee"
		lib: 
			compiled: "lib.min.js"
		project: pkg.name
	paths:
		build: "./public"
		css:
			dest: "./public/styles"
			entry: "./src/stylus/"
		fonts:
			dest: "./public/styles/fonts"
			entry: "./src/styles/fonts"
		html:
			dest: "./public"
			entry: "./src/jade/"
		images:
			dest: "./public/images"
			entry: "./src/images/"
		js:
			dest: "./public/scripts"
			entry: "./src/coffeescript/"
		lib:
			dest: "./public/scripts/lib"
			entry: "./src/bower_components/"
		project: "./"
		source: "./src"
	port: 8080
	url: pkg.homepage
	version: pkg.version