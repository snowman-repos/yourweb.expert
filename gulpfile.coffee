"use strict"

gulp = require "gulp"
requireDirectory = require "require-directory"
$ = require("gulp-load-plugins")(lazy: false)

config = require "./gulp/config"

loadTasks = (mod) ->
	mod gulp, $, config

tasks = requireDirectory module, "./gulp/tasks",
	recurse: true
	visit: loadTasks