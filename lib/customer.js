var Base, Customer, Q, request, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Q = require("q");

request = require("../util/request");

Base = require("./base");

Customer = (function(_super) {
  __extends(Customer, _super);

  function Customer() {
    _ref = Customer.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Customer.prototype.path = "customers";

  Customer.prototype.Class = Customer;

  Customer.prototype.create = function(req) {
    var attr, deferred,
      _this = this;
    deferred = Q.defer();
    if (req == null) {
      req = {};
    }
    attr = {};
    if (req.card != null) {
      if ((req.card.number != null) && (req.card.exp_month != null) && (req.card.exp_year != null) && (req.card.cvc != null) && (req.card.name != null)) {
        attr.card = req.card;
      } else {
        deferred.reject(new Error("Invalid card infomation"));
      }
    }
    if (req.email != null) {
      attr.email = req.email;
    }
    if (req.description != null) {
      attr.description = req.description;
    }
    request({
      method: "POST",
      path: "customers",
      attr: attr,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(new Customer(_this.api_key, res));
    });
    return deferred.promise;
  };

  Customer.prototype.save = function(req) {
    var attr, deferred,
      _this = this;
    deferred = Q.defer();
    attr = {};
    if (this.card != null) {
      if ((this.card.number != null) && (this.card.exp_month != null) && (this.card.exp_year != null) && (this.card.cvc != null) && (this.card.name != null)) {
        attr.card = this.card;
      } else {
        deferred.reject(new Error("Invalid card infomation"));
      }
    }
    if (this.email != null) {
      attr.email = this.email;
    }
    if (this.description != null) {
      attr.description = this.description;
    }
    request({
      method: "POST",
      path: "customers/" + this.id,
      attr: attr,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(new Customer(_this.api_key, res));
    });
    return deferred.promise;
  };

  Customer.prototype["delete"] = function(req) {
    var deferred;
    deferred = Q.defer();
    request({
      method: "DELETE",
      path: "customers/" + this.id,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  Customer.prototype.retrieve = require("../util/retrieve");

  Customer.prototype.all = require("../util/all");

  return Customer;

})(Base);

module.exports = Customer;
