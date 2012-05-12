require 'spec_helper'

describe Page do
  describe "name" do
    before { @page = Factory.create :page }

    it "must be present" do
      page = Factory.build :page, :name => nil
      page.should be_invalid
    end

    it "must be unique" do
      page = Factory.build :page, :name => @page.name
      page.should be_invalid
    end
  end

  describe "title" do
    it "must be present" do
      page = Factory.build :page, :title => nil
      page.should be_invalid
    end
  end

  describe "section_name" do
    it "must be present" do
      page = Factory.build :page, :section_name => nil
      page.should be_invalid
    end
  end
end
