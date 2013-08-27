Q = require "q"
Base = require "./base"

class Event extends Base
	path: "events"
	Class: Event

	all: require "../util/all"
	retrieve: require "../util/retrieve"

module.exports = Event
