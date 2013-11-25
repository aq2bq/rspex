require 'pry-byebug'

class RSpecExamples
  SPEC_PATH = "#{Gem.path[0]}/gems/*/spec/*_spec.rb"

  def initialize
    @examples = Dir.glob(SPEC_PATH).map{|path| Example.new(path)}
  end

  def search word, type
    @examples.select{|example| example.matches word, type }
  end
end


class Example
  attr_reader :path, :all, :describes, :contexts, :its, :results

  def initialize path
    @path = path
    @all = open(path).read
    types = %w(describe context it)
    types.each{|type| self.instance_variable_set("@#{type}s",[])}
    @results = []
    @all.each_line do |line|
      types.each do |type|
        self.instance_variable_get("@#{type}s") << line.chomp.strip if line =~ /.*#{type} .* do$/
      end
    end
  end

  def name
    @path.match(/^.*gems\/(.*)\/spec\//)[1]
  end

  def matches word, type
    examples = self.instance_variable_get("@#{type}s")
    if examples.any?
      @results = examples.select{|example| example.include? word}
    end
    @results.any? ? @results : false
  end
end