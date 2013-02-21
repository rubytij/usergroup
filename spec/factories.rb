FactoryGirl.define do
  sequence :username do |n|
    "user#{n}"
  end

  sequence :title do |n|
    "theme #{n}"
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

  sequence :name do |n|
    "name#{n}"
  end

  factory :role do
    name { Factory.next :role_name }
  end

  factory :user do
    email            { Factory.next :email }
    username         { Factory.next :username }
    github_uid       { Factory.next :uid }
    github_username  { Factory.next :username }
    name             'Super developer'
  end

  factory :page do
    name    { Factory.next :name }
    section :home
    title   { Factory.next :title }
    content 'hello'
    main_page true
  end

  factory :post do
    title   { Factory.next :title }
    content "Lorem ipsum"
    user
  end

  factory :event do
    name { Factory.next :name }
    starts_at { Date.today }
    ends_at { 1.day.from_now }
    description 'Discuss Time and Space'
    association :user
  end

  factory :contact_form do
    name  { Factory.next :name }
    email { Factory.next :email }
    message 'Who let the dogs out?'
  end
end
