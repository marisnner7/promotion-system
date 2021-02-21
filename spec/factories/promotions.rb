# frozen_string_literal: true

FactoryBot.define do
  factory :promotion do
    name { 'Natal' }
    description { 'Promoção de Natal' }
    code { 'NATAL10' }
    discount_rate { '15' }
    coupon_quantity { 5 }
    expiration_date { '22/12/2033' }
  end
end
