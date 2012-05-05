FactoryGirl.define do
  sequence :username do |n|
    "user#{n}"
  end

  sequence :email do |n|
    "user#{n}@email.com"
  end

  sequence :uid do |n|
    "11#{n}"
  end

  sequence :role_name do |n|
    "role_#{n}"
  end

  sequence :section_name do |n|
    "section_#{n}"
  end

  sequence :url_friendly_name do |n|
    "friendly_name#{n}"
  end

  factory :user do
    email       { Factory.next :email }
    username    { Factory.next :username }
    github_uid  { Factory.next :uid }
    name        'Super developer'
    roles       { |r| [Factory.build :role] }
  end

  factory :role do
    name { Factory.next :role_name }
  end

  factory :section do
    name              { Factory.next :section_name }
    url_friendly_name { Factory.next :url_friendly_name }
    description       "Section Description"
  end
end
