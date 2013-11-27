require "rspex"
require 'thor'

module RSpex
  class CLI < Thor
    desc "it 'keyword'", "search keyword from 'it' sentence."
    def it(word)
      search word, 'it'
    end

    desc "context 'keyword'", "search keyword from 'context' sentence."
    def context(word)
      search word, 'context'
    end
    
    desc "describe 'keyword'", "search keyword from 'describe' sentence."
    def describe(word)
      search word, 'describe'
    end

    private
    def search word, type
      i = 0
      examples = RSpex.examples
      results = examples.search(word, type)
      results.each do |example|
        say("\n", :black)
        say("[#{example.path}]", :on_blue)
        example.results.each{|result| say(result, :on_black)}
        i += example.results.size
      end
      say("\n", :black)
      say("found #{i} example(s) on #{results.size}/#{examples.size} spec(s)", :on_red)
    end
  end
end
