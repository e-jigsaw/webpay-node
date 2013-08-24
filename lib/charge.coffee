Q = require "q"
request = require "./request"

class Charge
	constructor: (@api_key)->

	create: (req)=>
		deferred = Q.defer()

		attr =
			description: if req.description? then req.description else null
			capture: if req.capture? then req.capture else true

		if req?.amount? and req?.currency?
			attr.amount = req.amount
			attr.currency = req.currency
		else
			deferred.reject new Error "Amount and currency is required"

		if req.customer? or req.card?
			if req.card?
				if req.card.number? and req.card.exp_month? and req.card.exp_year? and req.card.cvc? and req.card.name?
					attr.card =
						number: req.card.number
						exp_month: req.card.exp_month
						exp_year: req.card.exp_year
						cvc: req.card.cvc
						name: req.card.name
				else
					deferred.reject new Error "Card param is required"
		else
			deferred.reject new Error "Customer or card is required"
		request
			method: "POST"
			path: "charges"
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
			path: "charges/#{req.id}"
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

	refund: (req)->
		deferred = Q.defer()

		deferred.reject new Error "ID is required" if !req?.id?
		attr = {}
		attr.amount = req.amount if req.amount?

		request
			method: "POST"
			path: "charges/#{req.id}/refund"
			attr: attr
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

	capture: (req)->
		deferred = Q.defer()

		deferred.reject new Error "ID is required" if !req?.id?
		attr = {}
		attr.amount = req.amount if req.amount?

		request
			method: "POST"
			path: "charges/#{req.id}/capture"
			attr: attr
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

	all: (req)->
		deferred = Q.defer()

		req = {} if !req?

		attr = {}
		attr.count = req.count if req.count?
		attr.offset = req.offset if req.offset?
		attr.created = req.created if req.created?
		attr.customer = req.customer if req.customer?

		request
			method: "GET"
			path: "charges"
			attr: attr
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

module.exports = Charge
