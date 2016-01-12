"use strict"

express = require "express"
controller = require "./currency.controller"

router = express.Router()

router.get "/", controller.index

module.exports = router