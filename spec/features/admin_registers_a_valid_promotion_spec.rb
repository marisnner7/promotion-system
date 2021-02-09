require 'rails_helper'

feature 'Admin registers a valid promotion' do

  before(:each) do
    
    user = create(:user)
    login_as(user, scope: :user)
    
  end
  
  scenario 'and attributes cannot be blank' do
    create(:promotion)

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Código', with: ''
    fill_in 'Desconto', with: ''
    fill_in 'Quantidade de cupons', with: ''
    click_on 'Criar promoção'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'and code must be unique' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Código', with: 'NATAL10'
    click_on 'Criar promoção'

    expect(page).to have_content('deve ser único')
  end
end

