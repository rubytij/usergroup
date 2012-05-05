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

  factory :user do
    email       { Factory.next :email }
    username    { Factory.next :username }
    github_uid  { Factory.next :uid }
    name        'Super developer'
  end

  factory :role do
    name { Factory.next :role_name }
  end

  factory :post do
    title       { Factory.next :title }
    content     "Lorem ipsum"
    user
  end
end
