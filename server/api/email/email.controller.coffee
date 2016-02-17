"use strict"

config = require "../../config/environment"
jade = require "jade"
Mailgun = require "mailgun-js"

exports.index = (req, res) ->

	mailgun = new Mailgun
		apiKey: config.mailgun.key
		domain: config.mailgun.domain

	template = jade.renderFile __dirname + "/template.jade",
		date: new Date().toString()
		message: req.body.message
		senderEmail: req.body.senderEmail
		senderName: req.body.senderName

	data =
		from: req.body.senderEmail
		html: template
		subject: "YourWeb.Expert Contact Form"
		to: "contact@yourweb.expert"

	mailgun.messages().send data, (err, body) ->

		if err
			console.log err
			res.jsonp err
		else
			console.log "OK"
			res.jsonp "sent"