Q = require "q"
request = require "../util/request"
all = require "../util/all"
Base = require "./base"

class Event extends Base
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
		all
			path: "events"
			api_key: @api_key
			Class: Event
			req: req

module.exports = Event
