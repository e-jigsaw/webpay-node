Q = require "q"
request = require "../util/request"
Base = require "./base"

class Account extends Base
	path: "account"
	Class: Account

module.exports = Account
