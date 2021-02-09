require 'rails_helper'

feature 'Admin registers a promotion' do
  #include_context 'When authenticated'

  before(:each) do
    
    user = create(:user)
    login_as(user, scope: :user)
    create(:promotion)

  end

  
  scenario 'from index page' do
    visit root_path
    click_on 'Promoções'

    expect(page).to have_link('Registrar uma promoção',
                              href: new_promotion_path)
  end

  xscenario 'successfully' do
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'

      
    fill_in 'Nome', with: promotion.name
    fill_in 'Descrição', with: promotion.description
    #fill_in 'Código', with: 'NATAL10'
    fill_in 'Desconto', with: promotion.discount_rate
    fill_in 'Quantidade de cupons', with: promotion.coupon_quantity

    # TODO fill_in 'Data de término', with: '22/12/2033'
    click_on 'Criar promoção'

  
    #expect(current_path).to eq(promotion_path(promotion))
    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('10,00%')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('10')
    expect(page).to have_link('Voltar')
  end
end
