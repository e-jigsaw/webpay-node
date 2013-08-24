var Customer, Q, request;

Q = require("q");

request = require("./request");

Customer = (function() {
  function Customer(api_key) {
    this.api_key = api_key;
  }

  Customer.prototype.create = function(req) {
    var attr, deferred;
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
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  Customer.prototype.get = function(req) {
    var deferred;
    deferred = Q.defer();
    if ((req != null ? req.id : void 0) == null) {
      deferred.reject(new Error("ID is required"));
    }
    request({
      method: "GET",
      path: "customers/" + req.id,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  Customer.prototype.update = function(req) {
    var attr, deferred;
    deferred = Q.defer();
    if ((req != null ? req.id : void 0) == null) {
      deferred.reject(new Error("ID is required"));
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
      path: "customers/" + req.id,
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

  Customer.prototype["delete"] = function(req) {
    var deferred;
    deferred = Q.defer();
    if ((req != null ? req.id : void 0) == null) {
      deferred.reject(new Error("ID is required"));
    }
    request({
      method: "DELETE",
      path: "customers/" + req.id,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  Customer.prototype.list = function(req) {
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
      path: "customers",
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

  return Customer;

})();

module.exports = Customer;
