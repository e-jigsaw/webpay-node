var Event, Q, request;

Q = require("q");

request = require("./request");

Event = (function() {
  function Event(api_key) {
    this.api_key = api_key;
  }

  Event.prototype.get = function(req) {
    var deferred;
    deferred = Q.defer();
    if ((req != null ? req.id : void 0) == null) {
      deferred.reject(new Error("ID is required"));
    }
    request({
      method: "GET",
      path: "events/" + req.id,
      api_key: this.api_key
    }, function(err, res) {
      if (err != null) {
        deferred.reject(err);
      }
      return deferred.resolve(res);
    });
    return deferred.promise;
  };

  Event.prototype.list = function(req) {
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
      path: "events",
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

  return Event;

})();

module.exports = Event;
