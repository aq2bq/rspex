require 'pathname'

class RSpecExamples
  SPEC_PATH = "#{Gem.default_dir}/gems/*/spec/**/*_spec.rb"
  attr_reader :examples, :size

  def initialize(spec_path=SPEC_PATH)
    @examples = Dir.glob(spec_path).map{|path| Example.new(path)}
  end

  def search word, type
    @examples.select{|example| example.matches word, type }
  end

  def size
    @examples.size
  end
end


class Example
  attr_reader :path, :name, :describes, :contexts, :its, :results

  def initialize path
    raise ('argument must be path to spec file') unless valid?(path)
    @path = path
    @name = path.match(/^.*gems\/(.*)\/spec\//)[1]
    @results = []
    types = %w(describe context it)
    types.each{|type| self.instance_variable_set("@#{type}s",[])}
    
    open(path).read.each_line do |line|
      types.each do |type|
        if line =~ /.*#{type} .* do$/
          set_example type, line.chomp.strip
        end
      end
    end
  end

  def matches word, type
    if examples(type).any?
      @results = examples(type).select{|example| example.include? word}
    end
    @results.any? ? @results : false
  end

  private
  def examples(type)
    self.instance_variable_get("@#{type}s")
  end

  def valid?(path)
    Pathname.new(path).exist? and path.include?('spec.rb')
  end

  def set_example type, sentence
    examples(type) << sentence unless examples(type).include? sentence
  end
end