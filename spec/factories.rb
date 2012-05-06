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

  sequence :page_name do |n|
    "page_#{n}"
  end

  sequence :section_id do |n|
    "11#{n}"
  end

  factory :user do
    email       { Factory.next :email }
    username    { Factory.next :username }
    github_uid  { Factory.next :uid }
    name        'Super developer'
  end

  factory :role do
    name { Factory.next :role_name }
  end

  factory :section do
    name              { Factory.next :section_name }
    description       "Section Description"
  end

  factory :page do
    name        { Factory.next :page_name }
    section_id  { Factory.next :section_id }
    title       "Page Title"
    tags        "Tags"
    content     "hello"
  end
end
