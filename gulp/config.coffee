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
		build: "./client/public"
		css:
			dest: "./client/public/styles"
			entry: "./client/src/stylus/"
		fonts:
			dest: "./client/public/styles/fonts"
			entry: "./client/src/styles/fonts"
		html:
			dest: "./client/public"
			entry: "./client/src/jade/"
		images:
			dest: "./client/public/images"
			entry: "./client/src/images/"
		js:
			dest: "./client/public/scripts"
			entry: "./client/src/coffeescript/"
		lib:
			dest: "./client/public/scripts/lib"
			entry: "./client/src/bower_components/"
		project: "./client/"
		source: "./client/src"
	port: 8080
	url: pkg.homepage
	version: pkg.version