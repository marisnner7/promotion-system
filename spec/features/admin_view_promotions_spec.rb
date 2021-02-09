require 'rails_helper'

feature 'Admin view promotions' do
  
  before(:each) do
    
    user = create(:user)
    login_as(user, scope: :user)
    create(:promotion)

  end
  
  scenario 'and no promotion are created', :broken => true do
    visit root_path
    click_on 'Promoções'
  
    expect(page).to have_content('Nenhuma promoção cadastrada')
  end

  scenario 'successfully' do
    
    visit root_path
    click_on 'Promoções'

    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('10,00%')
  end

  scenario 'and view details' do

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'

    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('10,00%')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('10')
  end


  scenario 'and return to home page' do

    visit root_path
    click_on 'Promoções'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  scenario 'and return to promotions page' do

    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Voltar'

    expect(current_path).to eq promotions_path
  end
end
