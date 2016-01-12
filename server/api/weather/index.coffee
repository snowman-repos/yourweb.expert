"use strict"

express = require "express"
controller = require "./weather.controller"

router = express.Router()

router.get "/", controller.index

module.exports = router