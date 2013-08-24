Q = require "q"
request = require "./request"

class Token
	constructor: (@api_key)->

	create: (req)->
		deferred = Q.defer()

		attr = {}
		if req.card?
			if req.card.number? and req.card.exp_month? and req.card.exp_year? and req.card.cvc? and req.card.name?
				attr.card = req.card
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

	get: (req)->
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
