require 'spec_helper'


describe Fake do
  describe '.create' do
    context "when params are valid" do
      it "returns true" do
        expect(subject).to be_true
      end
    end
    context "when params are invalid" do
      it "returns false" do
        expect(subject).to be_false
      end
    end
  end
end

feature "Feature Fake" do
  scenario "is pulled in" do
    visit('/foo')
    page.body.should include('Another World')
  end
end
