Q = require "q"
request = require "../util/request"
all = require "../util/all"
Base = require "./base"

class Charge extends Base
	path: "charges"
	Class: Charge

	create: (req)->
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
		, (err, res)=>
			deferred.reject err if err?
			deferred.resolve new Charge @api_key, res

		deferred.promise

	refund: (req)->
		deferred = Q.defer()

		req = {} if !req?

		attr = {}
		attr.amount = req.amount if req.amount?

		request
			method: "POST"
			path: "charges/#{@id}/refund"
			attr: attr
			api_key: @api_key
		, (err, res)=>
			deferred.reject err if err?
			deferred.resolve new Charge @api_key, res

		deferred.promise

	capture: (req)->
		deferred = Q.defer()

		req = {} if !req?

		attr = {}
		attr.amount = req.amount if req.amount?

		request
			method: "POST"
			path: "charges/#{@id}/capture"
			attr: attr
			api_key: @api_key
		, (err, res)=>
			deferred.reject err if err?
			deferred.resolve new Charge @api_key, res

		deferred.promise

	all: (req)-> 
		all
			path: "charges"
			api_key: @api_key
			Class: Charge
			req: req
		

module.exports = Charge
