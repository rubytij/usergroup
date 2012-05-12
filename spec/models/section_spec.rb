require 'spec_helper'

describe Section do
  describe 'name' do
    before { @section = Factory.create :section }

    it "must be present" do
      section = Factory.build :section, :name => nil
      section.should be_invalid
    end

    it "must be unique" do
      section = Factory.build :section, :name => @section.name
      section.should be_invalid
    end
  end
end
