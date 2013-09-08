var Account, Base, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Base = require("./base");

Account = (function(_super) {
  __extends(Account, _super);

  function Account() {
    _ref = Account.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Account.prototype.path = "account";

  Account.prototype.Class = Account;

  Account.prototype.retrieve = require("../util/retrieve");

  return Account;

})(Base);

module.exports = Account;
