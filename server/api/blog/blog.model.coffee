mongoose = require "mongoose"
Schema = mongoose.Schema

TumblrSchema = new Schema
	accessToken: String
	accessTokenSecret: String

module.exports = mongoose.model "Blog", TumblrSchema