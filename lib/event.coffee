Q = require "q"
request = require "./request"

class Event
	constructor: (@api_key, res)-> @[key] = value for key, value of res if res?

	retrieve: (id)->
		deferred = Q.defer()

		deferred.reject new Error "ID is required" if !id?

		request
			method: "GET"
			path: "events/#{id}"
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
			data = res.data
			delete res.data
			events = {}
			events[key] = value for key, value of res
			events.data = for event in data
				new Event @api_key, event
			deferred.resolve events

		deferred.promise

module.exports = Event
