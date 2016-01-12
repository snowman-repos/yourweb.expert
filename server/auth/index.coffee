"use strict"

express = require "express"
passport = require "passport"
config = require "../config/environment"
User = require "../api/users/users.model"

# Passport Configuration
require("./local/passport").setup User, config

router = express.Router()

router.use "/local", require "./local"
router.use "/tumblr", require "./tumblr"

module.exports = router