require 'spec_helper'

describe ContactForm do
  describe 'email' do
    it 'must be present' do
      email = build :contact_form, :email => nil
      email.should be_invalid
    end

    it 'must be properly formatted' do
      email = build :contact_form, :email => 'not valid'
      email.should be_invalid
      email.email = 'someone@somewhere.net'
      email.should be_valid
    end
  end

  describe 'nickname captcha' do
    # This is a validation for spam if present then the email is spam
    it 'should not be present' do
      email = build :contact_form, :nickname => 'present'
      email.should be_spam
    end
  end

  describe 'name' do
    it 'must be present' do
      email = build :contact_form, :name => nil
      email.should be_invalid
    end
  end

  describe 'message' do
    it 'must be present' do
      email = build :contact_form, :message => nil
      email.should be_invalid
    end
  end
end
