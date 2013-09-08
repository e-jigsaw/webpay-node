var Base, Event, Q, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Q = require("q");

Base = require("./base");

Event = (function(_super) {
  __extends(Event, _super);

  function Event() {
    _ref = Event.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Event.prototype.path = "events";

  Event.prototype.Class = Event;

  Event.prototype.all = require("../util/all");

  Event.prototype.retrieve = require("../util/retrieve");

  return Event;

})(Base);

module.exports = Event;
