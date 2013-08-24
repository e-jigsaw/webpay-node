var https, qs;

https = require("https");

qs = require("qs");

module.exports = function(params, cb) {
  var key, options, query, req, value, _ref, _ref1;
  options = {
    hostname: "api.webpay.jp",
    port: 443,
    path: "/v1/" + params.path,
    method: params.method,
    headers: {
      "Authorization": "Bearer " + params.api_key
    }
  };
  if (params.method === "POST") {
    query = {};
    _ref = params.attr;
    for (key in _ref) {
      value = _ref[key];
      query[key] = value;
    }
    query = qs.stringify(query);
    options.headers["Content-Length"] = query.length;
  }
  if (params.method === "GET" && (params.attr != null)) {
    query = {};
    _ref1 = params.attr;
    for (key in _ref1) {
      value = _ref1[key];
      query[key] = value;
    }
    query = qs.stringify(query);
    options.path = "" + options.path + "?" + query;
  }
  req = https.request(options, function(res) {
    var str;
    str = "";
    res.on("data", function(data) {
      return str += data;
    });
    return res.on("end", function() {
      return cb(null, JSON.parse(str));
    });
  });
  req.on("error", function(err) {
    return cb(err);
  });
  if (params.method === "POST") {
    req.write(query);
  }
  return req.end();
};
