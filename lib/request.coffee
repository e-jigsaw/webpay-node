https = require "https"
qs = require "qs"

module.exports = (params, cb)->
	options =
		hostname: "api.webpay.jp"
		port: 443
		path: "/v1/#{params.path}"
		method: params.method
		headers:
			"Authorization": "Bearer #{params.api_key}"		
	
	if params.method is "POST"
		query = {}
		query[key] = value for key, value of params.attr
		query = qs.stringify query
		options.headers["Content-Length"] = query.length

	if params.method is "GET" and params.attr?
		query = {}
		query[key] = value for key, value of params.attr
		query = qs.stringify query
		options.path = "#{options.path}?#{query}"
	
	req = https.request options, (res)->
		str = ""
		res.on "data", (data)-> str += data
		res.on "end", -> cb null, JSON.parse str
	req.on "error", (err)-> cb err
	req.write query if params.method is "POST"
	req.end()
