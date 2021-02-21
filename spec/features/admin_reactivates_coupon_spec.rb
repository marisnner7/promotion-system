# frozen_string_literal: true

require 'rails_helper'

feature 'Admin reactivates coupon' do
  background do
    user = create(:user)
    login_as user
  end

  scenario 'successfully' do
    visit root_path
    promotion = create(:promotion)
    promotion.generate_coupons!

    promotion.coupons.first.inactive!
    promotion.coupons.first.active!

    click_on 'Promoções'
    click_on 'Natal'

    expect(page).to have_content('NATAL10-0001 (Active)')
    expect(promotion.coupons.first).to be_active
  end

  scenario 'and the coupon is active' do
    visit root_path
    promotion = create(:promotion)
    promotion.generate_coupons!

    promotion.coupons.first.inactive!
    promotion.coupons.first.active!

    click_on 'Promoções'
    click_on 'Natal'

    expect(page).to_not have_link('Reativar')
  end
end
