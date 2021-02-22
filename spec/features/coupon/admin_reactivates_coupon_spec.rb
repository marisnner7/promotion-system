# frozen_string_literal: true

require 'rails_helper'

feature 'Admin reactivates coupon' do
  background do
    user = create(:user)
    login_as user
    visit root_path
   
  end

  scenario 'and the coupon is inactive' do
    promotion = create(:promotion)
    promotion.generate_coupons!
    promotion.coupons.first.inactive!

    click_on 'Promoções'
    click_on 'Natal'

    expect(page).to have_link('Reativar cupom')
  end

  scenario 'and the coupon is reactivated' do
    promotion = create(:promotion)
    promotion.generate_coupons!
    promotion.coupons.first.inactive!

    visit promotion_path(promotion)
    click_on 'Reativar cupom'




    expect(page).to have_content('Cupom reativado com sucesso')

  end
end
