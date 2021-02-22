# frozen_string_literal: true

require 'rails_helper'
describe 'Admin inactivate coupon' do
  it 'successfully' do
    promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                  description: 'Promoção de Cyber Monday',
                                  code: 'CYBER15', discount_rate: 15,
                                  expiration_date: '22/12/2033')
    coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')
    user = User.create!(email: 'jane_doe@locaweb.com.br', password: '123456')

    login_as user, scope: :user
    visit promotion_path(promotion)
    click_on 'Desativar cupom'

    expect(page).to have_content('Cupom cancelado com sucesso')
    expect(page).to have_content('CYBER15-0001 (Inactive)')
    expect(page).not_to have_link('Descartar cupom')
    expect(coupon.reload).to be_inactive
  end
end
