require 'rspec_examples'

describe RSpecExamples do
  before do
    @rspec_examples = RSpecExamples.new
  end
  let(:word) { 'valid' }
  let(:type) { 'context' }

  describe '#search' do
    before do
      @results = @rspec_examples.search(word, type)
    end
    
    context "when valid arguments" do
      it { expect(@results.first.name).to eq "capybara-webkit-1.0.0" }
    end
  end
end

describe Example do
  let(:path) { "#{Gem.path[0]}/gems/capybara-1.0.1/spec/rspec_spec.rb" }
  before do
    @example = Example.new(path)
  end

  describe '#name' do
    context "when valid path" do
      it { expect(@example.name).to eq 'capybara-1.0.1' }
    end
  end

  describe '#all' do
    context "when valid path" do
      it { expect(@example.all).to eq "require 'spec_helper'\nrequire 'capybara/rspec'\n\nCapybara.app = TestApp\n\ndescribe 'capybara/rspec', :type => :request do\n  it \"should include Capybara in rspec\" do\n    visit('/foo')\n    page.body.should include('Another World')\n  end\n\n  context \"resetting session\" do\n    it \"sets a cookie in one example...\" do\n      visit('/set_cookie')\n      page.body.should include('Cookie set to test_cookie')\n    end\n\n    it \"...then it is not availbable in the next\" do\n      visit('/get_cookie')\n      page.body.should_not include('test_cookie')\n    end\n  end\n\n  context \"setting the current driver\" do\n    it \"sets the current driver in one example...\" do\n      Capybara.current_driver = :selenium\n    end\n\n    it \"...then it has returned to the default in the next example\" do\n      Capybara.current_driver.should == :rack_test\n    end\n  end\n\n  it \"switches to the javascript driver when giving it as metadata\", :js => true do\n    Capybara.current_driver.should == Capybara.javascript_driver\n  end\n\n  it \"switches to the given driver when giving it as metadata\", :driver => :culerity do\n    Capybara.current_driver.should == :culerity\n  end\nend\n\ndescribe 'capybara/rspec', :type => :other do\n  it \"should not include Capybara\" do\n    expect { visit('/') }.to raise_error(NoMethodError)\n  end\nend\n\nfeature \"Feature DSL\" do\n  scenario \"is pulled in\" do\n    visit('/foo')\n    page.body.should include('Another World')\n  end\nend\n" }
    end
  end

  describe '#describes' do
    context "when valid path" do
      it { expect(@example.describes).to have(2).items }
      it { expect(@example.describes.first).to eq "describe 'capybara/rspec', :type => :request do" }
    end
  end

  describe '#contexts' do
    context "when valid path" do
      it { expect(@example.contexts).to have(2).items }
      it { expect(@example.contexts.first).to eq "context \"resetting session\" do" }
    end
  end

  describe '#its' do
    context "when valid path" do
      it { expect(@example.its).to have(8).items }
      it { expect(@example.its.first).to eq "it \"should include Capybara in rspec\" do" }
    end
  end
end