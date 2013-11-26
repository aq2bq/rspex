require "rspex/version"
require "rspex/cli"
require 'rspec_examples'

module RSpex
  class << self
    def examples
      @examples = RSpecExamples.new
    end
  end
end
