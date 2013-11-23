require 'pry-byebug'

class RSpecExamples
  SPEC_PATH = "#{Gem.path}/gems/*/spec/*_spec.rb"

  def initialize
    @specs = Dir.glob(SPEC_PATH).tap{|path| Example.new(path)}
  end

  def search str
  end

end


class Example
  def initialize path
    @path = path
  end

  def all
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