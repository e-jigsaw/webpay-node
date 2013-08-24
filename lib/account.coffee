Q = require "q"
request = require "./request"

class Account
	constructor: (@api_key)->

	retrieve: ->
		deferred = Q.defer()

		request
			method: "GET"
			path: "account"
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

module.exports = Account
