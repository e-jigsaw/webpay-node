var Base, Q, Token, request, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Q = require("q");

request = require("../util/request");

Base = require("./base");

Token = (function(_super) {
  __extends(Token, _super);

  function Token() {
    _ref = Token.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Token.prototype.path = "tokens";

  Token.prototype.Class = Token;

  Token.prototype.create = function(req) {
    var attr, deferred,
      _this = this;
    deferred = Q.defer();
    attr = {};
    if (req != null) {
      if ((req.number != null) && (req.exp_month != null) && (req.exp_year != null) && (req.cvc != null) && (req.name != null)) {
        attr.card = req;
      } else {
        deferred.reject(new Error("Invalid card infomation"));
      }
    } else {
      deferred.reject(new Error("Card infomation is required"));
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
      return deferred.resolve(new Token(_this.api_key, res));
    });
    return deferred.promise;
  };

  Token.prototype.retrieve = require("../util/retrieve");

  return Token;

})(Base);

module.exports = Token;
