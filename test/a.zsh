#! /usr/local/bin/zsh

function foo() {
  echo "1: foo"
}
foo

bar() {
  echo "2: bar"
}
bar

baz() { echo "3: baz" }
baz

-foo() { echo "4: -foo" }
-foo

/foo() { echo "5: /foo" }
/foo

+foo() { echo "6: +foo" }
+foo

_foo() { echo "7: _foo" }
_foo

0foo() { echo "8: 0foo" }
0foo

123() { echo "9: 123" }
123

+++() { echo "10: +++" }
+++

/+-() { echo "11: /+-" }
/+-

function xyz { echo "12: xyz" }
xyz

function() {
  echo "function() anonymous"
}

function {
  echo "function anonymous"
}

() {
  echo "() anonymous"
}

# INVALID
?a() { echo ?a }
?a
