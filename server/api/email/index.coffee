"use strict"

express = require "express"
controller = require "./email.controller"

router = express.Router()

router.post "/", controller.index

module.exports = router