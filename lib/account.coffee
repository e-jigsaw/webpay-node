Q = require "q"
request = require "../util/request"
Base = require "./base"

class Account extends Base
	retrieve: ->
		deferred = Q.defer()

		request
			method: "GET"
			path: "account"
			api_key: @api_key
		, (err, res)=>
			deferred.reject err if err?
			deferred.resolve new Account @api_key, res

		deferred.promise

module.exports = Account
