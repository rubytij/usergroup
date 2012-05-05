require 'spec_helper'

describe Section do
  before { @section = Factory.create :section }

  describe 'name' do
    it "must be present" do
      section = Factory.build :section, :name => ''
      section.should be_invalid
    end

    it "can't be nil" do
      section = Factory.build :section, :name => nil
      section.should be_invalid
    end

    it "must be unique" do
      section = Factory.build :section, :name => @section.name
      section.should be_invalid
    end
  end

  describe "description" do
    it "can be blank" do
      section = Factory.build :section, :description => ""
      section.should be_valid
    end
  end
end
