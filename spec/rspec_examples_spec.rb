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
      it { expect(@search.first.results).to eq ["context \"when params are valid\" do", "context \"when params are invalid\" do"] }
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
      it { expect(@example.all).to eq "require 'spec_helper'\n\n\ndescribe Fake do\n  describe '.create' do\n    context \"when params are valid\" do\n      it \"returns true\" do\n        expect(subject).to be_true\n      end\n    end\n    context \"when params are invalid\" do\n      it \"returns false\" do\n        expect(subject).to be_false\n      end\n    end\n  end\nend\n\n" }
      it { expect(@example.describes).to have(2).items }
      it { expect(@example.describes.first).to eq "describe Fake do" }
      it { expect(@example.contexts).to have(2).items }
      it { expect(@example.contexts.first).to eq "context \"when params are valid\" do" }
      it { expect(@example.its).to have(2).items }
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
    let(:type) { 'context' }

    context "Success in match the word" do
      let(:word) { 'valid' }
      it { expect(@matches).to have(2).items }
      it { expect(@example.results).to eq ["context \"when params are valid\" do", "context \"when params are invalid\" do"] }
    end
    
    context "Fail in match the word" do
      let(:word) { 'xxx' }
      it { expect(@matches).to be_false }
      it { expect(@example.results).to be_empty }
    end
  end
end