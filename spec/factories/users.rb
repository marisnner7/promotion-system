# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@locaweb.com.br" }
    password { '123456' }
  end
end
