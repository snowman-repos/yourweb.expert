# Populate DB with sample data on server start
# to disable, edit config/environment/index.js, and set `seedDB: false`

"use strict"

# e.g. Users

# User = require "../api/users/users.model"
#
# User.find({}).remove ->
# 	User.create
# 		provider: "local",
# 		name: "Test User",
# 		email: "test@test.com",
# 		password: "test"
# 	,
# 		provider: "local",
# 		role: "admin",
# 		name: "Darryl Snow",
# 		email: "dazsnow@gmail.com",
# 		password: "mugwuffin"
# 	, ->
# 			console.log "finished populating users"