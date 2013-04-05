require 'spec_helper'

describe Post do
  let(:user) { create :user }

  describe "title" do
    it "must be present" do
      build( :post, :title => nil ).should be_invalid
    end

    it "must be unique" do
      create :post, :title => 'foo'
      build( :post, :title => 'foo').should be_invalid
    end
  end

  describe "content" do
    it "must have content" do
      build( :post, :content => nil ).should be_invalid
    end
  end

  describe "user" do
    it "must have a user" do
      build( :post, :user_id => nil ).should be_invalid
    end
  end

  describe "accesible attributes" do
    it "should not allow access to user_id" do
      expect { Post.new( :user_id => user ) }.to raise_error( ActiveModel::MassAssignmentSecurity::Error )
    end
  end
end
