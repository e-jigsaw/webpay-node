Q = require "q"
request = require "./request"

module.exports = (req)->
	deferred = Q.defer()

	req = {} if !req?

	attr = {}
	attr.count = req.count if req.count?
	attr.offset = req.offset if req.offset?
	attr.created = req.created if req.created?
	attr.customer = req.customer if req.customer?

	request
		method: "GET"
		path: @path
		attr: attr
		api_key: @api_key
	, (err, res)=>
		deferred.reject err if err?
		data = res.data
		delete res.data
		objects = {}
		objects[key] = value for key, value of res
		objects.data = for object in data
			new @Class @api_key, object
		deferred.resolve objects

	deferred.promise
