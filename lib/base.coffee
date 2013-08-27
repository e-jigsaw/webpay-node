Q = require "q"
request = require "../util/request"

class Base
	constructor: (@api_key, res)-> @[key] = value for key, value of res if res?

	retrieve: (id)->
		deferred = Q.defer()
		
		if id?
			path = "#{@path}/#{id}"
		else
			path = @path
			
		request
			method: "GET"
			path: path
			api_key: @api_key
		, (err, res)=>
			deferred.reject err if err?
			deferred.resolve new @Class @api_key, res

		deferred.promise

module.exports = Base
