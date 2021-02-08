FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@locaweb.com" }
    password { '123456' }
  end
end
