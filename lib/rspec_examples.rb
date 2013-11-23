require 'pry-byebug'

class RSpecExamples
  SPEC_PATH = "#{Gem.path[0]}/gems/*/spec/*_spec.rb"

  def initialize
    @specs = Dir.glob(SPEC_PATH).tap{|path| Example.new(path)}
  end

  def search str
  end

end


class Example
  attr_reader :all, :describes, :contexts, :its

  def initialize path
    @path = path
    @all = open(path).read
    @describes = []
    @contexts = []
    @its = []
    @all.each_line do |line|
      @describes << line.chomp.strip if line =~ /.*describe .* do$/
      @contexts << line.chomp.strip if line =~ /.*context .* do$/
      @its << line.chomp.strip if line =~ /.*it .* do$/
    end
  end

  def name
    @path.match(/^.*gems\/(.*)\/spec\//)[1]
  end
end