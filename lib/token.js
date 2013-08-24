var Q, Token, request;

Q = require("q");

request = require("./request");

Token = (function() {
  function Token(api_key) {
    this.api_key = api_key;
  }

  Token.prototype.create = function(req) {
    var attr, deferred;
    deferred = Q.defer();
    attr = {};
    if (req.card != null) {
      if ((req.card.number != null) && (req.card.exp_month != null) && (req.card.exp_year != null) && (req.card.cvc != null) && (req.card.name != null)) {
        attr.card = req.card;
      } else {
        deferred.reject(new Error("Invalid card infomation"));
      }
    }
    request({
      method: "POST",
      path: "tokens",
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

  Token.prototype.get = function(req) {
    var deferred;
    deferred = Q.defer();
    if ((req != null ? req.id : void 0) == null) {
      deferred.reject(new Error("ID is required"));
    }
    request({
      method: "GET",
      path: "tokens/" + req.id,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  return Token;

})();

module.exports = Token;
