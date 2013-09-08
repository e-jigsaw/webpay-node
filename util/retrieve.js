var Q, request;

Q = require("q");

request = require("../util/request");

module.exports = function(id) {
  var deferred, path,
    _this = this;
  deferred = Q.defer();
  if (id != null) {
    path = "" + this.path + "/" + id;
  } else {
    path = this.path;
  }
  request({
    method: "GET",
    path: path,
    api_key: this.api_key
  }, function(err, res) {
    if (err != null) {
      deferred.reject(err);
    }
    return deferred.resolve(new _this.Class(_this.api_key, res));
  });
  return deferred.promise;
};
