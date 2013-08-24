var Account, Q, request;

Q = require("q");

request = require("./request");

Account = (function() {
  function Account(api_key) {
    this.api_key = api_key;
  }

  Account.prototype.get = function() {
    var deferred;
    deferred = Q.defer();
    request({
      method: "GET",
      path: "account",
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  return Account;

})();

module.exports = Account;
