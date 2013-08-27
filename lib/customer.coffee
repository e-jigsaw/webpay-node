Q = require "q"
request = require "../util/request"
Base = require "./base"

class Customer extends Base
	constructor: (@api_key, res)-> @[key] = value for key, value of res if res?

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
		, (err, res)=>
			deferred.reject err if err?
			deferred.resolve new Customer @api_key, res

		deferred.promise

	retrieve: (req)->
		deferred = Q.defer()
		
		deferred.reject new Error "ID is required" if !req?.id?
			
		request
			method: "GET"
			path: "customers/#{req.id}"
			api_key: @api_key
		, (err, res)=>
			deferred.reject err if err?
			deferred.resolve new Customer @api_key, res

		deferred.promise

	save: (req)->
		deferred = Q.defer()

		attr = {}
		if @card?
			if @card.number? and @card.exp_month? and @card.exp_year? and @card.cvc? and @card.name?
				attr.card = @card
			else
				deferred.reject new Error "Invalid card infomation"
		attr.email = @email if @email?
		attr.description = @description if @description?

		request
			method: "POST"
			path: "customers/#{@id}"
			attr: attr
			api_key: @api_key
		, (err, res)=>
			deferred.reject err if err?
			deferred.resolve new Customer @api_key, res

		deferred.promise

	delete: (req)->
		deferred = Q.defer()

		request
			method: "DELETE"
			path: "customers/#{@id}"
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
			path: "customers"
			attr: attr
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			data = res.data
			delete res.data
			customers = {}
			customers[key] = value for key, value of res
			customers.data = for customer in data
				new Customer @api_key, customer
			deferred.resolve customers

		deferred.promise

module.exports = Customer
