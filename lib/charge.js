var Charge, Q, request,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Q = require("q");

request = require("./request");

Charge = (function() {
  function Charge(api_key) {
    this.api_key = api_key;
    this.create = __bind(this.create, this);
  }

  Charge.prototype.create = function(req) {
    var attr, deferred;
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
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  Charge.prototype.get = function(req) {
    var deferred;
    deferred = Q.defer();
    if ((req != null ? req.id : void 0) == null) {
      deferred.reject(new Error("ID is required"));
    }
    request({
      method: "GET",
      path: "charges/" + req.id,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  Charge.prototype.refund = function(req) {
    var attr, deferred;
    deferred = Q.defer();
    if ((req != null ? req.id : void 0) == null) {
      deferred.reject(new Error("ID is required"));
    }
    attr = {};
    if (req.amount != null) {
      attr.amount = req.amount;
    }
    request({
      method: "POST",
      path: "charges/" + req.id + "/refund",
      attr: attr,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  Charge.prototype.capture = function(req) {
    var attr, deferred;
    deferred = Q.defer();
    if ((req != null ? req.id : void 0) == null) {
      deferred.reject(new Error("ID is required"));
    }
    attr = {};
    if (req.amount != null) {
      attr.amount = req.amount;
    }
    request({
      method: "POST",
      path: "charges/" + req.id + "/capture",
      attr: attr,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  Charge.prototype.list = function(req) {
    var attr, deferred;
    deferred = Q.defer();
    if (req == null) {
      req = {};
    }
    attr = {};
    if (req.count != null) {
      attr.count = req.count;
    }
    if (req.offset != null) {
      attr.offset = req.offset;
    }
    if (req.created != null) {
      attr.created = req.created;
    }
    if (req.customer != null) {
      attr.customer = req.customer;
    }
    request({
      method: "GET",
      path: "charges",
      attr: attr,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  return Charge;

})();

module.exports = Charge;
