require 'spec_helper'

describe Page do
  describe "name" do
    let(:new_page) { Factory.create :page }

    it "must be present" do
      page = Factory.build :page, :name => nil
      page.should be_invalid
    end

    it "must be unique" do
      page = Factory.build :page, :name => new_page.name
      page.should be_invalid
    end
  end

  describe "title" do
    it "must be present" do
      page = Factory.build :page, :title => nil
      page.should be_invalid
    end
  end

  describe "section" do
    it "must be present" do
      page = Factory.build :page, :section => nil
      page.should be_invalid
    end
  end
end
