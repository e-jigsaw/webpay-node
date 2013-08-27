Q = require "q"
Base = require "./base"

class Event extends Base
	path: "events"
	Class: Event

	all: require "../util/all"

module.exports = Event
