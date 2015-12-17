"use strict"

express			= require "express"
JadeInheritance	= require "jade-inheritance"
open			= require "open"
path			= require "path"
tinylr			= require "tiny-lr"

module.exports = (gulp, $, config) ->

	gulp.task "dev", ["build"], ->

		app = express()
		lr = tinylr()
		app.use require("connect-livereload")()
		app.use express.static config.paths.build
		app.listen config.port
		lr.listen config.livereloadPort

		# if executed with a --env production option
		if $.util.env.env == "production"
			open config.url
		else
			open "http://localhost:" + config.port

		# Update the livereload server
		notifyLivereload = (event) ->

			fileName = "/" + path.relative config.paths.build, event.path

			$.util.log $.util.colors.yellow fileName + " updated"

			lr.changed
				body:
					files: [fileName]

		gulp.watch [
			config.paths.css.dest + "/**/*.css"
			config.paths.fonts.dest + "/**/*.{woff,ttf,otf,svg}"
			config.paths.html.dest + "/*.html"
			config.paths.images.dest + "/**/*.{jpg,png,gif,svg,xml}"
			config.paths.js.dest + "/**/*.js"
			config.paths.lib.dest + "/*.{js,css}"
		], notifyLivereload

		$.watch config.paths.js.entry + "**/*.coffee", ->
			gulp.start "coffeescript"

		$.watch config.paths.css.entry + "**/*.styl", ->
			gulp.start "stylus"

		$.watch config.paths.fonts.entry + "**/*.{woff,ttf,otf,svg}", ->
			gulp.start "copy-files"

		$.watch config.paths.html.entry + "**/*.jade", (file) ->
			gulp.start "jade"

			basedir = process.cwd()
			fileName = path.relative basedir, file.path
			dependants = []
			inheritance = null
			filter = ["!./src/jade/*/**/*.jade"]

			# get dependant of changed/add/remove file
			try
				inheritance = new JadeInheritance fileName, ".",
					basedir: "."
			catch error
				throw new $.util.PluginError "watch jade",
					message: err

			if inheritance and inheritance.files
				for filepath in inheritance.files
					filepath = "./" + filepath
					dependants.push filepath
					
				dependants = dependants.concat filter	
					
				gulp.src dependants
				.pipe $.plumber()
				.pipe $.jade
					pretty: true
					data:
						description: config.description
						keywords: config.keywords
				.pipe gulp.dest config.paths.html.dest

		$.watch config.paths.images.entry + "**/*.{jpg,png,gif,svg,xml}", ->
			gulp.start "images"

		$.watch config.paths.lib.entry + "**/*.{js,css}", ->
			gulp.start "libs"

		$.watch config.paths.source + "*.{txt,json}", ->
			gulp.start "copy-files"