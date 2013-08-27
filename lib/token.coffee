Q = require "q"
request = require "../util/request"
Base = require "./base"

class Token extends Base
	path: "tokens"
	Class: Token

	create: (req)->
		deferred = Q.defer()

		attr = {}
		if req?
			if req.number? and req.exp_month? and req.exp_year? and req.cvc? and req.name?
				attr.card = req
			else
				deferred.reject new Error "Invalid card infomation"
		else
			deferred.reject new Error "Card infomation is required"

		request
			method: "POST"
			path: "tokens"
			attr: attr
			api_key: @api_key
		, (err, res)=>
			deferred.reject err if err?
			deferred.resolve new Token @api_key, res

		deferred.promise

module.exports = Token
