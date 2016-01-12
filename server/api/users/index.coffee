"use strict"

express = require "express"
controller = require "./users.controller"
config = require "../../config/environment"
auth = require "../../auth/auth.service"

router = express.Router()

router.get "/", auth.isAuthenticated(), auth.hasRole("admin"), controller.index
router.delete "/:id", auth.isAuthenticated(), auth.hasRole("admin"), controller.destroy
router.put "/password/:id", auth.isAuthenticated(), controller.changePassword
router.put "/:id", auth.isAuthenticated(), auth.hasRole("admin"), controller.update
router.get "/:id", auth.isAuthenticated(), auth.hasRole("admin"), controller.show
router.post "/", controller.create

module.exports = router