require 'rspec_examples'

describe RSpecExamples do
  describe '#search' do
  end
end

describe Example do
  let(:path) { '/Users/pememo/.rbenv/versions/2.0.0-p195/lib/ruby/gems/2.0.0/gems/capybara-1.0.1/spec/rspec_spec.rb' }
  before do
    @example = Example.new(path)
  end

  describe '#name' do
    context "when valid path" do
      it { expect(@example.name).to eq 'capybara-1.0.1' }
    end
  end
end