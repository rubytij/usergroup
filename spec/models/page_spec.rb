require 'spec_helper'

describe Page do
  before { @section = Factory.create :section
           @page = Factory.create :page, :section_id => @section.id }

  describe "name" do
    it "must be present" do
      page = Factory.build :page, :name => ""
      page.should be_invalid
    end

    it "can't be nil" do
      page = Factory.build :page, :name => nil
      page.should be_invalid
    end

    it "must be unique" do
      page = Factory.build :page, :name => @page.name
      page.should be_invalid
    end
  end

  describe "section_id" do
    it "must have a section" do
      page = Factory.build :page, :section_id => nil
      page.should be_invalid
    end
  end
end
