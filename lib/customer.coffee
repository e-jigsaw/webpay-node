Q = require "q"
request = require "./request"

class Customer
	constructor: (@api_key)->

	create: (req)->
		deferred = Q.defer()

		req = {} if !req?

		attr = {}
		if req.card?
			if req.card.number? and req.card.exp_month? and req.card.exp_year? and req.card.cvc? and req.card.name?
				attr.card = req.card
			else
				deferred.reject new Error "Invalid card infomation"
		attr.email = req.email if req.email?
		attr.description = req.description if req.description?

		request
			method: "POST"
			path: "customers"
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
			path: "customers/#{req.id}"
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

	update: (req)->
		deferred = Q.defer()

		deferred.reject new Error "ID is required" if !req?.id?

		attr = {}
		if req.card?
			if req.card.number? and req.card.exp_month? and req.card.exp_year? and req.card.cvc? and req.card.name?
				attr.card = req.card
			else
				deferred.reject new Error "Invalid card infomation"
		attr.email = req.email if req.email?
		attr.description = req.description if req.description?

		request
			method: "POST"
			path: "customers/#{req.id}"
			attr: attr
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

	delete: (req)->
		deferred = Q.defer()

		deferred.reject new Error "ID is required" if !req?.id?

		request
			method: "DELETE"
			path: "customers/#{req.id}"
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

	list: (req)->
		deferred = Q.defer()

		req = {} if !req?

		attr = {}
		attr.count = req.count if req.count?
		attr.offset = req.offset if req.offset?
		attr.created = req.created if req.created?
		attr.customer = req.customer if req.customer?

		request
			method: "GET"
			path: "customers"
			attr: attr
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

module.exports = Customer
