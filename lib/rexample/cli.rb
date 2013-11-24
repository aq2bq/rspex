require "rexample"
require 'thor'
require 'rspec_examples'

module Rexample
  class CLI < Thor
    desc "it WORD", "show result."
    def it(word)
      search word, 'it'
    end

    desc "context WORD", "show result."
    def context(word)
      search word, 'context'
    end
    
    desc "describe WORD", "show result."
    def describe(word)
      search word, 'describe'
    end

    desc "describe WORD, it or describe or context", "show result."
    def search word, type
      RSpecExamples.new.search(word, type).each do |example|
        say("[#{example.path}]", :green)
        example.instance_variable_get("@#{type}s").each {|str|say(str, :yellow) if str.include? word}
      end
    end
  end
end
