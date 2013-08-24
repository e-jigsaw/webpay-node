Charge = require "./lib/charge"
Customer = require "./lib/customer"
Token = require "./lib/token"
Event = require "./lib/event"
Account = require "./lib/account"

class WebPay
	constructor: (@api_key)->
		throw new Error "API key is required" if @api_key is undefined
		@charge = new Charge @api_key
		@customer = new Customer @api_key
		@token = new Token @api_key
		@event = new Event @api_key
		@account = new Account @api_key

module.exports = WebPay
