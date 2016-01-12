"use strict"

User = require "./users.model"
passport = require "passport"
config = require "../../config/environment"
jwt = require "jsonwebtoken"

validationError = (res, err) ->
	return res.send(422).jsonp err

# Get list of users
# restriction: "admin"

exports.index = (req, res) ->
	User.find {}, "-salt -hashedPassword", (err, users) ->
		if err then res.status(500).send err
		res.status(200).jsonp users

# Creates a new user

exports.create = (req, res, next) ->
	newUser = new User req.body
	newUser.provider = "local"
	newUser.role = "user"
	newUser.save (err, user) ->
		if err then validationError res, err
		token = jwt.sign
			_id: user._id
		, config.secrets.session
		, expiresInMinutes: 60*5
		res.jsonp
			user: user
			token: token

# Get a single user

exports.show = (req, res, next) ->
	userId = req.params.id

	User.findById userId, (err, user) ->
		if err then next err
		if !user then res.sendStatus 401
		res.jsonp user.profile

# Deletes a user
# restriction: "admin"

exports.destroy = (req, res) ->
	User.findByIdAndRemove req.params.id, (err, user) ->
		if err then res.status(500).send err
		res.sendStatus 204


# Change a users password

exports.changePassword = (req, res, next) ->
	userId = req.user._id
	oldPass = String req.body.oldPassword
	newPass = String req.body.newPassword

	User.findById userId, (err, user) ->
		if user.authenticate(oldPass)
			user.password = newPass
			user.save (err) ->
				if err then validationError res, err
				res.sendStatus 200
		else
			res.sendStatus 403

# Update user profile

exports.update = (req, res, next) ->
	userId = req.params.id
	newName = req.body.name
	newEmail = req.body.email

	User.findById userId, (err, user) ->
		user.name = newName
		user.email = newEmail
		user.save (err) ->
			if err then validationError res, err
			res.sendStatus 200

# Get my info

exports.me = (req, res, next) ->
	userId = req.user._id
	User.findOne
		_id: userId
	, "-salt -hashedPassword", (err, user) -> # don"t ever give out the password or salt
		if err then next err
		if !user then res.sendStatus 401
		res.jsonp user


# Authentication callback

exports.authCallback = (req, res, next) ->
	res.redirect "/"