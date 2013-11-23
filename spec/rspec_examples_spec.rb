require 'rspec_examples'

describe RSpecExamples do
  describe '#search' do
  end
end

describe Example do
  let(:path) { Dir.glob("#{Gem.path}/gems/*/spec/*_spec.rb").first }
  before do
    @example = Example.new(path)
  end

  describe '#name' do
    context "when valid path" do
      it { expect(@example.name).to eq 'awesome_print-1.2.0' }
    end
  end
end