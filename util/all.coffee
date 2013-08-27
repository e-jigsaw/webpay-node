Q = require "q"
request = require "./request"

module.exports = (params)->
	deferred = Q.defer()

	params.req = {} if !params.req?

	attr = {}
	attr.count = params.req.count if params.req.count?
	attr.offset = params.req.offset if params.req.offset?
	attr.created = params.req.created if params.req.created?
	attr.customer = params.req.customer if params.req.customer?

	request
		method: "GET"
		path: params.path
		attr: attr
		api_key: params.api_key
	, (err, res)->
		deferred.reject err if err?
		data = res.data
		delete res.data
		objects = {}
		objects[key] = value for key, value of res
		objects.data = for object in data
			new params.Class params.api_key, object
		deferred.resolve objects

	deferred.promise
