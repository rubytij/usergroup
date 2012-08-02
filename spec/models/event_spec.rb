require 'spec_helper'

describe Event do
  before :each do
    @user = Factory.create :user
  end

  describe "name" do
    it "must be present" do
      Factory.build( :event, :name => nil ).should be_invalid
    end
  end

  describe "user" do
    it "must have a user" do
      Factory.build( :event, :user_id => nil ).should be_invalid
    end
  end

  describe "start date and end date" do
    it "end must be greater than start" do
      Factory.build( :event, :starts_at => DateTime.now + 1.day, :ends_at => DateTime.now - 1.day ).should be_invalid
    end
  end

  describe "description" do
    it "must be present" do
      Factory.build( :event, :description => nil ).should be_invalid
    end
  end
end
