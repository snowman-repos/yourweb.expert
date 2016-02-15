"use strict"

# Development specific configuration
module.exports =
	mailgun:
		domain: "sandbox74ff1352a6c04b0881286922069f5691.mailgun.org"
		key: "key-0060c50fa65a88143feba16cff39b2aa"
	# MongoDB connection options
	mongo:
		uri: "mongodb://localhost/darrylsnow-dev"
	,
	seedDB: true