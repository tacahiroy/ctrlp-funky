function global_func() {
  return true;
}

function global_func2(x, y) {
  return x + y;
}

var f = function() {
  return true;
};

function init(x, y) {
  return function() {
    return x * y;
  };
};

var o = {
  version: 1,
  method1: function() {
    return true;
  }
};

