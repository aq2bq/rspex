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
    byebug
    @path = path
    @file = open(path)
  end

  def all
    @file.read
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