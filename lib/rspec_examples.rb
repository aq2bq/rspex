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
  def initialize path
    @path = path
    @file = open(path).read
  end

  def all
    @file
  end

  def name
    @path.match(/^.*gems\/(.*)\/spec\//)[1]
  end

  def describes
  end

  def contexts
  end

  def its
  end
end