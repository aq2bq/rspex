require 'rspec_examples'

describe RSpecExamples do
  before do
    @rspec_examples = RSpecExamples.new("fake/gems/*/spec/*_spec.rb")
  end

  let(:word) { 'valid' }
  let(:type) { 'context' }

  describe '#search' do
    before do
      @search = @rspec_examples.search(word, type)
    end
    
    context "when valid arguments" do
      it { expect(@search.first.name).to eq "fakegem-1.0.0" }
      it { expect(@search.first.results).to eq ["context \"when params are valid\" do", "context \"when params are invalid\" do"] }
    end
  end
end

describe Example do
  let(:path) { "fake/gems/fakegem-1.0.0/spec/fake_spec.rb" }
  before do
    @example = Example.new(path)
  end

  describe '#name' do
    context "when valid path" do
      it { expect(@example.name).to eq 'fakegem-1.0.0' }
    end
  end

  describe '#all' do
    context "when valid path" do
      it { expect(@example.all).to eq "require 'spec_helper'\n\n\ndescribe Fake do\n  describe '.create' do\n    context \"when params are valid\" do\n      it \"returns true\" do\n        expect(subject).to be_true\n      end\n    end\n    context \"when params are invalid\" do\n      it \"returns false\" do\n        expect(subject).to be_false\n      end\n    end\n  end\nend\n\nfeature \"Feature Fake\" do\n  scenario \"is pulled in\" do\n    visit('/foo')\n    page.body.should include('Another World')\n  end\nend\n" }
    end
  end

  describe '#describes' do
    context "when valid path" do
      it { expect(@example.describes).to have(2).items }
      it { expect(@example.describes.first).to eq "describe Fake do" }
    end
  end

  describe '#contexts' do
    context "when valid path" do
      it { expect(@example.contexts).to have(2).items }
      it { expect(@example.contexts.first).to eq "context \"when params are valid\" do" }
    end
  end

  describe '#its' do
    context "when valid path" do
      it { expect(@example.its).to have(2).items }
      it { expect(@example.its.first).to eq "it \"returns true\" do" }
    end
  end

  describe '#matches' do
    context "when valid path" do
      before do
        @example.matches(word, type)
      end
      let(:word) { 'valid' }
      let(:type) { 'context' }
      it { expect(@example.results).to eq ["context \"when params are valid\" do", "context \"when params are invalid\" do"] }
    end
  end
end