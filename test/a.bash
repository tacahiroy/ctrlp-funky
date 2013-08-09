#! /usr/local/bin/bash

function foo() {
  echo "foo"
}
foo

bar() {
  echo "bar"
}
bar

baz() { echo "baz"; }
baz

# -foo() { echo -foo }
# -foo

# /foo() { echo /foo }
# /foo

# +foo() { echo +foo }
# +foo

# _foo() { echo _foo }
# _foo

# 0foo() { echo 0foo }
# 0foo

# 123() { echo 123 }
# 123

# +++() { echo +++ }
# +++

# /+-() { echo /+- }
# /+-

# ?a() { echo ?a }
# ?a
