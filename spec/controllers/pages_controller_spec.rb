require 'spec_helper'

describe PagesController do
  describe "logged in" do
    it "should respond successfully if logged in" do
      #stub
    end

    before { @section = Factory.create :section
             @page    = Factory.create :page, :section_id => @section.id   }

    describe "create new page" do
      it "should redirect after creating page" do
        post :create, :page => Factory.attributes_for(:page, :section_id => @section.id)
        response.should redirect_to( page_path (assigns(:page)))
      end

      it "should render new if it fails" do
        post :create, :section => Factory.attributes_for( :page, :name => nil)
        response.should render_template( :new )
      end
    end

    describe "with existing page" do
      it "should render edit" do
        get :edit, :id => @page
        response.status.should eql (200)
        response.status.should render_template( :edit )
      end

      it "should update and redirect" do
        put :update, :id => @page, :page => { :name => "updatedpage" }
        response.should redirect_to ( page_path (@page) )
        @page.reload.name.should eql("updatedpage")
      end
    end
  end

  describe "not logged in" do
    #stub
  end
end
