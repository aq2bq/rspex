require 'rspec_examples'

describe RSpecExamples do
  before do
    @rspec_examples = RSpecExamples.new("fake/gems/*/spec/**/*_spec.rb")
  end

  let(:word) { 'valid' }
  let(:type) { 'context' }

  describe '#search' do
    before do
      @search = @rspec_examples.search(word, type)
    end
    
    context "Success in Search" do
      it { expect(@search.first.name).to eq "fakegem-1.0.0" }
      it { expect(@search.first.results).to eq ["context \"when params are valid\" do", "context \"when arguments are valid\" do", "context \"when params are invalid\" do"] }
    end

    context "Fail in Search" do
      let(:type) { 'describe' }
      it { expect(@search).to be_empty }
    end
  end
end

describe Example do
  let(:path) { "fake/gems/fakegem-1.0.0/spec/fake_spec.rb" }
  before do
    @example = Example.new(path)
  end

  describe '#attr_reader' do
    context "with a valid path" do
      it { expect(@example.describes.size).to eq(2) }
      it { expect(@example.describes.first).to eq "describe Fake do" }
      it { expect(@example.contexts.size).to eq(3) }
      it { expect(@example.contexts.first).to eq "context \"when params are valid\" do" }
      it { expect(@example.its.size).to eq(2) }
      it { expect(@example.its.first).to eq "it \"returns true\" do" }
    end
  end

  describe '#name' do
    context "with a valid path" do
      it { expect(@example.name).to eq 'fakegem-1.0.0' }
    end
    context "with an invalid path" do
      it { expect{Example.new('x')}.to raise_error('argument must be path to spec file') }
    end
  end

  describe '#matches' do
    before do
      @matches = @example.matches(word, type)
    end

    context 'When search from "context" sentences' do
      let(:type) { 'context' }

      context "Success in match the word" do
        let(:word) { 'valid' }
        it { expect(@matches.size).to eq(3) }
        it { expect(@example.results).to eq ["context \"when params are valid\" do", "context \"when arguments are valid\" do", "context \"when params are invalid\" do"] }
      end

      context "Fail in match the word" do
        let(:word) { 'xxx' }
        it { expect(@matches).to eq(false) }
        it { expect(@example.results).to be_empty }
      end
    end

    context 'When there are duplicated "it" sentences' do
      let(:type) { 'it' }
      let(:word) { 'true' }

      it "should be ignore duplicated sentence" do
        expect(@matches).to eq(["it \"returns true\" do"])
      end
    end
  end
end