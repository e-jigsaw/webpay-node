var Account, Charge, Customer, Event, Token, WebPay;

Charge = require("./lib/charge");

Customer = require("./lib/customer");

Token = require("./lib/token");

Event = require("./lib/event");

Account = require("./lib/account");

WebPay = (function() {
  function WebPay(api_key) {
    this.api_key = api_key;
    if (this.api_key === void 0) {
      throw new Error("API key is required");
    }
    this.charge = new Charge(this.api_key);
    this.customer = new Customer(this.api_key);
    this.token = new Token(this.api_key);
    this.event = new Event(this.api_key);
    this.account = new Account(this.api_key);
  }

  return WebPay;

})();

module.exports = WebPay;
