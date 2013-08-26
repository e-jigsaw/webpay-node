WebPay = require "../index"
should = require "should"

describe "index", ->
	testCard =
		number: "4242-4242-4242-4242"
		exp_month: 11
		exp_year: 2014
		cvc: 123
		name: "KEI KUBO"
	
	testCustomer =
		amount: 400
		currency: "jpy"
		card: testCard

	testAPIKey = "test_secret_eHn4TTgsGguBcW764a2KA8Yd"

	describe "constructor", ->
		it "should generate instance", ->
			webpay = new WebPay testAPIKey
			webpay.api_key.should.eql testAPIKey
		
		it "should throw error when param is undefined", ->
			try
				webpay = new WebPay()
			catch err
				err.should.be.an.instanceOf Error
				err.message.should.eql "API key is required"

	describe "charge", ->
		webpay = null
		id = null
		before -> webpay = new WebPay testAPIKey
		
		describe "#create", ->
			it "should send new charge", (done)->
				webpay.charge.create(testCustomer).done (charge)->
					charge.paid.should.be.true
					id = charge.id
					done()

		describe "#retrieve", ->
			it "should get charged info", (done)->
				webpay.charge.retrieve
					id: id
				.done (charge)->
					charge.id.should.eql id
					done()

		describe "#refund", ->
			it "should refund charge", (done)->
				webpay.charge.retrieve
					id: id
				.then (charge)-> charge.refund()
				.done (charge)->
					charge.id.should.eql id
					done()

		describe "#capture", ->
			before (done)->
				captureTestCustomer = testCustomer
				captureTestCustomer.capture = false
				webpay.charge.create(captureTestCustomer).done (charge)->
					id = charge.id
					done()
			it "should captured charge", (done)->
				webpay.charge.retrieve
					id: id
				.then (charge)-> charge.capture()
				.done (charge)->
					charge.id.should.eql id
					done()

		describe "#all", ->
			it "should get charged list", (done)->
				webpay.charge.all().done (charges)->
					charges.object.should.eql "list"
					done()

	describe "customer", ->
		webpay = null
		id = null
		before -> webpay = new WebPay testAPIKey

		describe "#create", ->
			it "should create customer", (done)->
				webpay.customer.create().done (customer)->
					customer.should.have.property "id"
					id = customer.id
					done()

		describe "#retrieve", ->
			it "should get customer infomation", (done)->
				webpay.customer.retrieve
					id: id
				.done (customer)->
					customer.id.should.eql id
					done()

		describe "#save", ->
			it "should update customer infomation", (done)->
				webpay.customer.retrieve
					id: id
				.then (customer)->
					customer.email = "test@te.st"
					customer.save()
				.done (customer)->
					customer.email.should.eql "test@te.st"
					done()

		describe "#delete", ->
			it "should delete customer infomation", (done)->
				webpay.customer.retrieve
					id: id
				.then (customer)->
					customer.delete()
				.done (res)->
					res.id.should.eql id
					res.deleted.should.be.true
					done()

		describe "#all", ->
			it "should get customers list", (done)->
				webpay.customer.all().done (customers)->
					customers.object.should.eql "list"
					done()

	describe "token", ->
		webpay = null
		id = null
		before -> webpay = new WebPay testAPIKey

		describe "#create", ->
			it "should create token", (done)->
				webpay.token.create(testCard).done (res)->
					res.should.have.property "id"
					id = res.id
					done()

		describe "#retrieve", ->
			it "should get token infomation", (done)->
				webpay.token.retrieve
					id: id
				.done (res)->
					res.id.should.eql id
					done()

	describe "event", ->
		webpay = null
		id = null
		before -> webpay = new WebPay testAPIKey

		describe "#all", ->
			it "should get events list", (done)->
				webpay.event.all().done (res)->
					res.data[0].should.have.property "id"
					id = res.data[0].id
					done()

		describe "#retrieve", ->
			it "should get event infomation", (done)->
				webpay.event.retrieve
					id: id
				.done (res)->
					res.id.should.eql id
					done()

	describe "account", ->
		webpay = null
		id = null
		before -> webpay = new WebPay testAPIKey

		describe "#retrieve", ->
			it "should get account infomation", (done)->
				webpay.account.retrieve().done (res)->
					res.should.have.property "id"
					done()
