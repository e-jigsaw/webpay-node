Q = require "q"
all = require "../util/all"
Base = require "./base"

class Event extends Base
	path: "events"
	Class: Event

	all: (req)->
		all
			path: "events"
			api_key: @api_key
			Class: Event
			req: req

module.exports = Event
