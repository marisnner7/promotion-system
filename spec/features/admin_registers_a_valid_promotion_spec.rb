# frozen_string_literal: true

require 'rails_helper'

feature 'Admin registers a valid promotion' do
  before(:each) do
    user = create(:user)
    login_as(user, scope: :user)
    create(:promotion)
  end

  scenario 'and attributes cannot be blank' do
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    within(".container") do
      fill_in 'Nome', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'Código', with: ''
      fill_in 'Desconto', with: ''
      fill_in 'Quantidade de cupons', with: ''
      click_on 'Criar promoção'
    end

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'and code must be unique' do
    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'
    fill_in 'Código', with: 'NATAL10'
    click_on 'Criar promoção'

    expect(page).to have_content('deve ser único')
  end
end
