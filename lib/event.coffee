Q = require "q"
request = require "./request"

class Event
	constructor: (@api_key)->

	retrieve: (req)->
		deferred = Q.defer()

		deferred.reject new Error "ID is required" if !req?.id?

		request
			method: "GET"
			path: "events/#{req.id}"
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
			path: "events"
			attr: attr
			api_key: @api_key
		, (err, res)->
			deferred.reject err if err?
			deferred.resolve res

		deferred.promise

module.exports = Event
