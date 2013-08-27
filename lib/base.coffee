class Base
	constructor: (@api_key, res)-> @[key] = value for key, value of res if res?

module.exports = Base
