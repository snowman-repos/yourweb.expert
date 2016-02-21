"use strict"

express			= require "express"
JadeInheritance	= require "jade-inheritance"
open			= require "open"
path			= require "path"
tinylr			= require "tiny-lr"

module.exports = (gulp, $, config) ->

	gulp.task "dev", ["build"], ->

		$.util.log $.util.colors.green "*******************************"
		$.util.log $.util.colors.green "Don't forget to run the server!"
		$.util.log $.util.colors.green "*******************************"

		app = express()
		lr = tinylr()
		app.use require("connect-livereload")()
		app.use express.static config.paths.client.build
		app.listen config.port
		lr.listen config.livereloadPort

		# if executed with a --env production option
		if $.util.env.env == "production"
			open config.url
		else
			open "http://localhost:" + config.port

		# Update the livereload server
		notifyLivereload = (event) ->

			fileName = "/" + path.relative config.paths.client.build, event.path

			$.util.log $.util.colors.yellow fileName + " updated"

			lr.changed
				body:
					files: [fileName]

		gulp.watch [
			config.paths.client.css.dest + "/**/*.css"
			config.paths.client.fonts.dest + "/**/*.{woff,ttf,otf,svg}"
			config.paths.client.html.dest + "/**/*.html"
			config.paths.client.images.dest + "/**/*.{jpg,png,gif,svg,webp,xml}"
			config.paths.client.js.dest + "/**/*.js"
		], notifyLivereload

		$.watch [config.paths.client.js.entry + "**/*.coffee", config.paths.client.js.entry + "**/!*.test.coffee"], ->
			gulp.start "coffeescript"

		$.watch [config.paths.client.css.entry + "**/*.styl", config.paths.client.css.entry + "**/*.html"], ->
			gulp.start "stylus"

		$.watch config.paths.client.fonts.entry + "**/*.{woff,ttf,otf,svg}", ->
			gulp.start "copy-files"

		$.watch config.paths.client.html.entry + "**/*.jade", (file) ->
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
				.pipe gulp.dest config.paths.client.html.dest

		$.watch config.paths.client.images.entry + "**/*.{jpg,png,gif,svg,webp,xml}", ->
			gulp.start "images"

		$.watch config.paths.client.source + "*.{txt,json}", ->
			gulp.start "copy-files"