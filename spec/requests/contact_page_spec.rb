require 'spec_helper'

describe "Contact Page" do
  before :each do
    create :page
    visit root_path
    click_link ContactForm.model_name.human
  end

  it "emails if all fields are filled in" do
    fill_in I18n.t('attributes.name'),    with: 'Batman'
    fill_in I18n.t('attributes.email'),   with: 'batman@batcave.com'
    fill_in I18n.t('attributes.message'), with: 'To the batmobile'
    click_button I18n.t('labels.send_email')

    ActionMailer::Base.deliveries.should_not be_empty
    current_path.should eql( contact_page_path )
  end
end
