var Base;

module.exports = Base = (function() {
  function Base(api_key, res) {
    var key, value;
    this.api_key = api_key;
    if (res != null) {
      for (key in res) {
        value = res[key];
        this[key] = value;
      }
    }
  }

  return Base;

})();
