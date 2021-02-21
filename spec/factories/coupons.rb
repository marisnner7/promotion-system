# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    sequence(:code) { |_n| nnnn.to_s }
    status { 0 }
    order { 'MyString' }
    promotion { Natal10 }
  end
end
