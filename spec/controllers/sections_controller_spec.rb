require 'spec_helper'

describe SectionsController do
  describe "logged in" do
    it "should respond successfully if logged in" do
      #stub
    end

    before { @section = Factory.create :section }

    describe "create new section" do
      it "should redirect after creating section" do
        post :create,  :section => Factory.attributes_for( :section )
        response.should redirect_to( section_path (assigns(:section).id))
      end

      it "should render new if it fails" do
        post :create, :section => Factory.attributes_for( :section, :name => nil)
        response.should render_template( :new )
      end
    end

    describe "with existing section" do
      it "should render edit" do
        get :edit, :id => @section
        response.status.should eql(200)
        response.status.should render_template(:edit)
      end

      it "should update and redirect" do
        put :update, :id => @section, :section => { :name => "newname" }
        response.should redirect_to( section_path (@section) )
        @section.reload.name.should eql("newname")
      end
    end
  end

  describe "not logged in" do
    #stub
  end
end
