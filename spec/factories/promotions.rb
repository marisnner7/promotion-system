FactoryBot.define do
  factory :promotion do
    name { "Natal" }
    description { "Promoção de Natal" }
    #create a sequence for uniq code
    sequence(:code)
    discount_rate { "10" }
    coupon_quantity { 10 }
    expiration_date { "22/12/2033" }
  end

end
