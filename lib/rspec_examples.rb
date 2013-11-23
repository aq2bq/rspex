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
  attr_reader :all, :describes

  def initialize path
    @path = path
    @all = open(path).read
    @describes = []
    File.foreach(path) do |line|
      @describes << line.chomp if line =~ /.*describe.*do$/ 
    end
  end

  def name
    @path.match(/^.*gems\/(.*)\/spec\//)[1]
  end

  def contexts
  end

  def its
  end
end