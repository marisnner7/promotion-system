FactoryBot.define do
  factory :coupon do
    sequence(:code) { |n| "#{nnnn}" }
    status { 0 }
    order { "MyString" }
    promotion { Natal10 }
  end
end
