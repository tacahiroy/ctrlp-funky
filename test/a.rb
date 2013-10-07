#! ruby

require "fileutils"
require_relative "foo"

include Foo

class Bar
  def initialize
    # init
  end
end

class Bar2 < Bar
end

class Klass; end

module Baz

end
