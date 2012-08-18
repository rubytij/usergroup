require 'spec_helper'

describe Post do
  let(:user) { Factory.create :user }

  describe "title" do
    it "must be present" do
      Factory.build( :post, :title => nil ).should be_invalid
    end

    it "must be unique" do
      Factory.create :post, :title => 'foo'
      Factory.build( :post, :title => 'foo').should be_invalid
    end
  end

  describe "content" do
    it "must have content" do
      Factory.build( :post, :content => nil ).should be_invalid
    end
  end

  describe "user" do
    it "must have a user" do
      Factory.build( :post, :user_id => nil ).should be_invalid
    end
  end

  describe "accesible attributes" do
    it "should not allow access to user_id" do
      expect do
        Post.new( :user_id => user )
      end.should raise_error( ActiveModel::MassAssignmentSecurity::Error )
    end
  end
end
