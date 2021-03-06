// Generated by CoffeeScript 1.10.0
module.exports = function(wSize, now, base) {
  if (now == null) {
    now = 0;
  }
  if (base == null) {
    base = 0;
  }
  return {
    back: function(n) {
      if (n == null) {
        n = 1;
      }
      now -= n;
      if (now < 0) {
        now += wSize;
      }
      return now;
    },
    go: function(n) {
      if (n == null) {
        n = 1;
      }
      now += n;
      if (now >= wSize) {
        now -= wSize;
      }
      return now;
    },
    next: function() {
      var n;
      n = now + 1;
      if (n >= wSize) {
        n -= wSize;
      }
      return n;
    },
    get: function() {
      return now;
    },
    set: function(x) {
      return now = x;
    },
    gt: function(x) {
      if (x < base) {
        x += wSize;
      }
      return now > x;
    },
    minus: function(x) {
      var n;
      n = now;
      if (n < base) {
        n += wSize;
      }
      return n - x;
    },
    getbase: function() {
      return base;
    },
    rebase: function(x) {
      return base = x;
    }
  };
};
