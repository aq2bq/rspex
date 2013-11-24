require 'pry-byebug'

class RSpecExamples
  SPEC_PATH = "#{Gem.path[0]}/gems/*/spec/*_spec.rb"

  def initialize
    @examples = Dir.glob(SPEC_PATH).map{|path| Example.new(path)}
  end

  def search word, type
    @examples.select{|example| example.match? word, type }
  end
end


class Example
  attr_reader :path, :all, :describes, :contexts, :its, :results

  def initialize path
    @path = path
    @all = open(path).read
    @describes = []
    @contexts = []
    @its = []
    @results = []
    @all.each_line do |line|
      @describes << line.chomp.strip if line =~ /.*describe .* do$/
      @contexts << line.chomp.strip if line =~ /.*context .* do$/
      @its << line.chomp.strip if line =~ /.*it .* do$/
    end
  end

  def name
    @path.match(/^.*gems\/(.*)\/spec\//)[1]
  end

  def match? word, type
    examples = self.instance_variable_get("@#{type}s")
    examples.any? ?
      examples.find{|example| example.include? word} : false
  end
end