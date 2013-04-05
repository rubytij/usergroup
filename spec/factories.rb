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
    name { generate :role_name }
  end

  factory :user do
    email       { generate :email }
    username    { generate :username }
    github_uid  { generate :uid }
    name        'Super developer'
  end

  factory :page do
    name    { generate :name }
    section :home
    title   { generate :title }
    content 'hello'
    main_page true
  end

  factory :post do
    title   { generate :title }
    content "Lorem ipsum"
    user
  end

  factory :event do
    name { generate :name }
    starts_at { Date.today }
    ends_at { 1.day.from_now }
    description 'Discuss Time and Space'
    association :user
  end

  factory :contact_form do
    name  { generate :name }
    email { generate :email }
    message 'Who let the dogs out?'
  end
end
