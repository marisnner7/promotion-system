# frozen_string_literal: true

require 'rails_helper'

describe 'Admin search for a promotion' do
  before do
    user = create(:user)
    login_as user, scope: :user
    create(:promotion)
  end

  it 'sucessfully' do
    visit root_path
    click_on 'Promoções'
    fill_in 'search[name]', with: 'Natal'
    click_on('Buscar promoção')

    expect(page).to have_current_path(promotions_path, ignore_query: true)
    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('15,00%')
  end

  it 'and promotion not found' do
    visit root_path
    fill_in 'search[name]', with: 'Cyber'
    click_on('Buscar promoção')
    expect(page).to have_current_path(promotions_path, ignore_query: true)
    expect(page).not_to have_content('Cyber Monday')
    expect(page).not_to have_content('Promoção de Cyber Monday')
    expect(page).not_to have_content('22/12/2033')
    expect(page).not_to have_content('15,00%')
    expect(page).to have_content('Nenhuma promoção encontrada')
  end
end
