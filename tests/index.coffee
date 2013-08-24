WebPay = require "../index"
should = require "should"

describe "index", ->
	describe "constructor", ->
		it "should generate instance", ->
			webpay = new WebPay "test_secret_eHn4TTgsGguBcW764a2KA8Yd"
			webpay.api_key.should.eql "test_secret_eHn4TTgsGguBcW764a2KA8Yd"
		
		it "should throw error when param is undefined", ->
			try
				webpay = new WebPay()
			catch err
				err.should.be.an.instanceOf Error
				err.message.should.eql "API key is required"

	describe "charge", ->
		webpay = null
		id = null
		before -> webpay = new WebPay "test_secret_eHn4TTgsGguBcW764a2KA8Yd"
		
		describe "#create", ->
			it "should send new charge", (done)->
				webpay.charge.create
					amount: 400
					currency: "jpy"
					card:
						number: "4242-4242-4242-4242"
						exp_month: 11
						exp_year: 2014
						cvc: 123
						name: "KEI KUBO"
				.done (res)->
					res.paid.should.be.true
					id = res.id
					done()

		describe "#get", ->
			it "should get charged info", (done)->
				webpay.charge.get
					id: id
				.done (res)->
					res.id.should.eql id
					done()

		describe "#refund", ->
			it "should refund charge", (done)->
				webpay.charge.refund
					id: id
				.done (res)->
					res.id.should.eql id
					done()

		describe "#capture", ->
			before (done)->
				webpay.charge.create
					amount: 400
					currency: "jpy"
					card:
						number: "4242-4242-4242-4242"
						exp_month: 11
						exp_year: 2014
						cvc: 123
						name: "KEI KUBO"
					capture: false
				.done (res)->
					id = res.id
					done()
			it "should captured charge", (done)->
				webpay.charge.capture
					id: id
				.done (res)->
					res.id.should.eql id
					done()

		describe "#list", ->
			it "should get charged list", (done)->
				webpay.charge.list().done (res)->
					res.should.have.property "count"
					done()

	describe "customer", ->
		webpay = null
		id = null
		before -> webpay = new WebPay "test_secret_eHn4TTgsGguBcW764a2KA8Yd"

		describe "#create", ->
			it "should create customer", (done)->
				webpay.customer.create().done (res)->
					res.should.have.property "id"
					id = res.id
					done()

		describe "#get", ->
			it "should get customer infomation", (done)->
				webpay.customer.get
					id: id
				.done (res)->
					res.id.should.eql id
					done()

		describe "#update", ->
			it "should update customer infomation", (done)->
				webpay.customer.update
					id: id
				.done (res)->
					res.id.should.eql id
					done()

		describe "#delete", ->
			it "should delete customer infomation", (done)->
				webpay.customer.delete
					id: id
				.done (res)->
					res.id.should.eql id
					res.deleted.should.be.true
					done()

		describe "#list", ->
			it "should get customers list", (done)->
				webpay.customer.list().done (res)->
					res.should.have.property "count"
					done()

	describe "token", ->
		webpay = null
		id = null
		before -> webpay = new WebPay "test_secret_eHn4TTgsGguBcW764a2KA8Yd"

		describe "#create", ->
			it "should create token", (done)->
				webpay.token.create
					card:
						number: "4242-4242-4242-4242"
						exp_month: 11
						exp_year: 2014
						cvc: 123
						name: "KEI KUBO"
				.done (res)->
					res.should.have.property "id"
					id = res.id
					done()

		describe "#get", ->
			it "should get token infomation", (done)->
				webpay.token.get
					id: id
				.done (res)->
					res.id.should.eql id
					done()

	describe "event", ->
		webpay = null
		id = null
		before -> webpay = new WebPay "test_secret_eHn4TTgsGguBcW764a2KA8Yd"

		describe "#list", ->
			it "should get events list", (done)->
				webpay.event.list().done (res)->
					res.data[0].should.have.property "id"
					id = res.data[0].id
					done()

		describe "#get", ->
			it "should get event infomation", (done)->
				webpay.event.get
					id: id
				.done (res)->
					res.id.should.eql id
					done()

	describe "account", ->
		webpay = null
		id = null
		before -> webpay = new WebPay "test_secret_eHn4TTgsGguBcW764a2KA8Yd"

		describe "#get", ->
			it "should get account infomation", (done)->
				webpay.account.get().done (res)->
					res.should.have.property "id"
					done()
