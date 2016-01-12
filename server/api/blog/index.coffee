"use strict"

express = require "express"
controller = require "./blog.controller"

router = express.Router()

router.get "/", controller.index

module.exports = router