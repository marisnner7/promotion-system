# frozen_string_literal: true

require 'rails_helper'

feature 'Admin view product categories' do
  before(:each) do
    user = create(:user)
    login_as(user, scope: :user)
    create(:product_category)
    create(:product_category, name: 'E-mail', code: 'EMAIL')
    visit root_path
  end

  scenario 'successfully' do
    click_on 'Categorias de produto'

    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('HOSP')
    expect(page).to have_content('E-mail')
    expect(page).to have_content('EMAIL')
  end

  scenario 'and show empty message', broken: true do
    click_on 'Categorias de produto'
    expect(page).to have_content('Nenhuma categoria cadastrada')
  end

  scenario 'and view details' do
    click_on 'Categorias de produto'
    click_on 'Hospedagem'

    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('HOSP')
  end
end
