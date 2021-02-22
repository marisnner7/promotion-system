# frozen_string_literal: true

require 'rails_helper'

describe 'Admin searches for coupon' do
  it 'successfully' do
    promotion = Promotion.create!(name: 'Cyber Monday',
                                  coupon_quantity: 100,
                                  description: 'Promoção de Cyber Monday',
                                  code: 'CYBER15', discount_rate: 15,
                                  expiration_date: '22/12/2033')
    promotion.coupons.create!(code: 'PAS0001', status: :active)
    promotion.coupons.create!(code: 'PAS0002', status: :active)
    user = User.create!(email: 'janedoe@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit root_path
    fill_in 'coupons_query', with: 'PAS0001'
    click_on 'Buscar cupom'

    expect(page).to have_current_path(coupons_path, ignore_query: true)
    expect(page).to have_content('PAS0001')
    expect(page).not_to have_content('PAS0002')
  end

  it 'and coupon not found' do
    promotion = Promotion.create!(name: 'Cyber Monday',
                                  coupon_quantity: 100,
                                  description: 'Promoção de Cyber Monday',
                                  code: 'CYBER15', discount_rate: 15,
                                  expiration_date: '22/12/2033')
    promotion.coupons.create!(code: 'PAS0001', status: :active)
    promotion.coupons.create!(code: 'PAS0002', status: :active)
    user = User.create!(email: 'janedoe@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit root_path
    fill_in 'coupons_query', with: 'PAS0007'
    click_on('Buscar cupom')

    expect(page).to have_current_path(coupons_path, ignore_query: true)
    expect(page).not_to have_content('PAS0001')
    expect(page).not_to have_content('PAS0002')
    expect(page).not_to have_content('PAS0007')
    expect(page).to have_content('Nenhum cupom encontrado')
  end
end
