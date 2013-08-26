Q = require "q"
request = require "./request"

class Token
	constructor: (@api_key)->

	create: (req)->
		deferred = Q.defer()

		attr = {}
		if req?
			if req.number? and req.exp_month? and req.exp_year? and req.cvc? and req.name?
				attr.card = req
			else
				deferred.reject new Error "Invalid card infomation"

		request
			method: "POST"
			path: "tokens"
			attr: attr
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

	retrieve: (req)->
		deferred = Q.defer()

		deferred.reject new Error "ID is required" if !req?.id?

		request
			method: "GET"
			path: "tokens/#{req.id}"
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

module.exports = Token
