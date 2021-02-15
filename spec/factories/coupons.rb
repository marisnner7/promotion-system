FactoryBot.define do
  factory :coupon do
    code { "xxxx" }
    status { 1 }
    order { "MyString" }
    promotion { Natal10 }
  end
end
