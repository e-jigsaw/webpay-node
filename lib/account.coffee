Q = require "q"
request = require "./request"

class Account
	constructor: (@api_key, res)-> @[key] = value for key, value of res if res?

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
