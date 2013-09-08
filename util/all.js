var Q, request;

Q = require("q");

request = require("./request");

module.exports = function(req) {
  var attr, deferred,
    _this = this;
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
    path: this.path,
    attr: attr,
    api_key: this.api_key
  }, function(err, res) {
    var data, key, object, objects, value;
    if (err != null) {
      deferred.reject(err);
    }
    data = res.data;
    delete res.data;
    objects = {};
    for (key in res) {
      value = res[key];
      objects[key] = value;
    }
    objects.data = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        object = data[_i];
        _results.push(new this.Class(this.api_key, object));
      }
      return _results;
    }).call(_this);
    return deferred.resolve(objects);
  });
  return deferred.promise;
};
