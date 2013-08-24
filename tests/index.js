var WebPay, should;

WebPay = require("../index");

should = require("should");

describe("index", function() {
  describe("constructor", function() {
    it("should generate instance", function() {
      var webpay;
      webpay = new WebPay("test_secret_eHn4TTgsGguBcW764a2KA8Yd");
      return webpay.api_key.should.eql("test_secret_eHn4TTgsGguBcW764a2KA8Yd");
    });
    return it("should throw error when param is undefined", function() {
      var err, webpay;
      try {
        return webpay = new WebPay();
      } catch (_error) {
        err = _error;
        err.should.be.an.instanceOf(Error);
        return err.message.should.eql("API key is required");
      }
    });
  });
  describe("charge", function() {
    var id, webpay;
    webpay = null;
    id = null;
    before(function() {
      return webpay = new WebPay("test_secret_eHn4TTgsGguBcW764a2KA8Yd");
    });
    describe("#create", function() {
      return it("should send new charge", function(done) {
        return webpay.charge.create({
          amount: 400,
          currency: "jpy",
          card: {
            number: "4242-4242-4242-4242",
            exp_month: 11,
            exp_year: 2014,
            cvc: 123,
            name: "KEI KUBO"
          }
        }).done(function(res) {
          res.paid.should.be["true"];
          id = res.id;
          return done();
        });
      });
    });
    describe("#retrieve", function() {
      return it("should get charged info", function(done) {
        return webpay.charge.retrieve({
          id: id
        }).done(function(res) {
          res.id.should.eql(id);
          return done();
        });
      });
    });
    describe("#refund", function() {
      return it("should refund charge", function(done) {
        return webpay.charge.refund({
          id: id
        }).done(function(res) {
          res.id.should.eql(id);
          return done();
        });
      });
    });
    describe("#capture", function() {
      before(function(done) {
        return webpay.charge.create({
          amount: 400,
          currency: "jpy",
          card: {
            number: "4242-4242-4242-4242",
            exp_month: 11,
            exp_year: 2014,
            cvc: 123,
            name: "KEI KUBO"
          },
          capture: false
        }).done(function(res) {
          id = res.id;
          return done();
        });
      });
      return it("should captured charge", function(done) {
        return webpay.charge.capture({
          id: id
        }).done(function(res) {
          res.id.should.eql(id);
          return done();
        });
      });
    });
    return describe("#all", function() {
      return it("should get charged list", function(done) {
        return webpay.charge.all().done(function(res) {
          res.should.have.property("count");
          return done();
        });
      });
    });
  });
  describe("customer", function() {
    var id, webpay;
    webpay = null;
    id = null;
    before(function() {
      return webpay = new WebPay("test_secret_eHn4TTgsGguBcW764a2KA8Yd");
    });
    describe("#create", function() {
      return it("should create customer", function(done) {
        return webpay.customer.create().done(function(res) {
          res.should.have.property("id");
          id = res.id;
          return done();
        });
      });
    });
    describe("#retrieve", function() {
      return it("should get customer infomation", function(done) {
        return webpay.customer.retrieve({
          id: id
        }).done(function(res) {
          res.id.should.eql(id);
          return done();
        });
      });
    });
    describe("#save", function() {
      return it("should update customer infomation", function(done) {
        return webpay.customer.save({
          id: id
        }).done(function(res) {
          res.id.should.eql(id);
          return done();
        });
      });
    });
    describe("#delete", function() {
      return it("should delete customer infomation", function(done) {
        return webpay.customer["delete"]({
          id: id
        }).done(function(res) {
          res.id.should.eql(id);
          res.deleted.should.be["true"];
          return done();
        });
      });
    });
    return describe("#all", function() {
      return it("should get customers list", function(done) {
        return webpay.customer.all().done(function(res) {
          res.should.have.property("count");
          return done();
        });
      });
    });
  });
  describe("token", function() {
    var id, webpay;
    webpay = null;
    id = null;
    before(function() {
      return webpay = new WebPay("test_secret_eHn4TTgsGguBcW764a2KA8Yd");
    });
    describe("#create", function() {
      return it("should create token", function(done) {
        return webpay.token.create({
          card: {
            number: "4242-4242-4242-4242",
            exp_month: 11,
            exp_year: 2014,
            cvc: 123,
            name: "KEI KUBO"
          }
        }).done(function(res) {
          res.should.have.property("id");
          id = res.id;
          return done();
        });
      });
    });
    return describe("#retrieve", function() {
      return it("should get token infomation", function(done) {
        return webpay.token.retrieve({
          id: id
        }).done(function(res) {
          res.id.should.eql(id);
          return done();
        });
      });
    });
  });
  describe("event", function() {
    var id, webpay;
    webpay = null;
    id = null;
    before(function() {
      return webpay = new WebPay("test_secret_eHn4TTgsGguBcW764a2KA8Yd");
    });
    describe("#all", function() {
      return it("should get events list", function(done) {
        return webpay.event.all().done(function(res) {
          res.data[0].should.have.property("id");
          id = res.data[0].id;
          return done();
        });
      });
    });
    return describe("#retrieve", function() {
      return it("should get event infomation", function(done) {
        return webpay.event.retrieve({
          id: id
        }).done(function(res) {
          res.id.should.eql(id);
          return done();
        });
      });
    });
  });
  return describe("account", function() {
    var id, webpay;
    webpay = null;
    id = null;
    before(function() {
      return webpay = new WebPay("test_secret_eHn4TTgsGguBcW764a2KA8Yd");
    });
    return describe("#retrieve", function() {
      return it("should get account infomation", function(done) {
        return webpay.account.retrieve().done(function(res) {
          res.should.have.property("id");
          return done();
        });
      });
    });
  });
});
