Base = require "./base"

class Account extends Base
	path: "account"
	Class: Account

	retrieve: require "../util/retrieve"

module.exports = Account
