require 'rails_helper'

feature 'Admin generates coupons' do
  before do
    user = create(:user)
    login_as user, scope: :user
    promotion = create(:promotion)

    visit root_path
    click_on 'Promoções'
    click_on  'Natal'
    click_on 'Gerar cupons'
  end
  
  scenario 'with coupon quantity available' do

    expect(page).to have_content('NATAL10-0001')
    expect(page).to have_content('NATAL10-0002')
    expect(page).to have_content('NATAL10-0003')
    expect(page).to have_content('NATAL10-0004')
    expect(page).to have_content('NATAL10-0005')
    expect(page).to have_content('Cupons gerados com sucesso')
    expect(page).not_to have_link('Emitir cupons')
  end

  scenario 'and coupons are already generated' do
    
    expect(page).not_to have_content('Emitir cupons')
    expect(page).to have_content("NATAL10")
  end
end