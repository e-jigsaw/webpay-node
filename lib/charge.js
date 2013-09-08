var Base, Charge, Q, request, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Q = require("q");

request = require("../util/request");

Base = require("./base");

Charge = (function(_super) {
  __extends(Charge, _super);

  function Charge() {
    _ref = Charge.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Charge.prototype.path = "charges";

  Charge.prototype.Class = Charge;

  Charge.prototype.create = function(req) {
    var attr, deferred,
      _this = this;
    deferred = Q.defer();
    attr = {
      description: req.description != null ? req.description : null,
      capture: req.capture != null ? req.capture : true
    };
    if (((req != null ? req.amount : void 0) != null) && ((req != null ? req.currency : void 0) != null)) {
      attr.amount = req.amount;
      attr.currency = req.currency;
    } else {
      deferred.reject(new Error("Amount and currency is required"));
    }
    if ((req.customer != null) || (req.card != null)) {
      if (req.card != null) {
        if ((req.card.number != null) && (req.card.exp_month != null) && (req.card.exp_year != null) && (req.card.cvc != null) && (req.card.name != null)) {
          attr.card = {
            number: req.card.number,
            exp_month: req.card.exp_month,
            exp_year: req.card.exp_year,
            cvc: req.card.cvc,
            name: req.card.name
          };
        } else {
          deferred.reject(new Error("Card param is required"));
        }
      }
    } else {
      deferred.reject(new Error("Customer or card is required"));
    }
    request({
      method: "POST",
      path: "charges",
      attr: attr,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(new Charge(_this.api_key, res));
    });
    return deferred.promise;
  };

  Charge.prototype.refund = function(req) {
    var attr, deferred,
      _this = this;
    deferred = Q.defer();
    if (req == null) {
      req = {};
    }
    attr = {};
    if (req.amount != null) {
      attr.amount = req.amount;
    }
    request({
      method: "POST",
      path: "charges/" + this.id + "/refund",
      attr: attr,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(new Charge(_this.api_key, res));
    });
    return deferred.promise;
  };

  Charge.prototype.capture = function(req) {
    var attr, deferred,
      _this = this;
    deferred = Q.defer();
    if (req == null) {
      req = {};
    }
    attr = {};
    if (req.amount != null) {
      attr.amount = req.amount;
    }
    request({
      method: "POST",
      path: "charges/" + this.id + "/capture",
      attr: attr,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(new Charge(_this.api_key, res));
    });
    return deferred.promise;
  };

  Charge.prototype.retrieve = require("../util/retrieve");

  Charge.prototype.all = require("../util/all");

  return Charge;

})(Base);

module.exports = Charge;
