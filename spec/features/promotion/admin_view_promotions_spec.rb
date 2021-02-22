# frozen_string_literal: true

require 'rails_helper'

describe Promotion do
  before do
    user = create(:user)
    login_as(user, scope: :user)
    create(:promotion)
  end

  it 'and no promotion are created', broken: true do
    visit root_path
    click_on 'Promoções'

    expect(page).to have_content('Nenhuma promoção cadastrada')
  end

  it 'successfully' do
    visit root_path
    click_on 'Promoções'

    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('15,00%')
  end

  it 'and view details' do
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'

    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('10')
  end

  it 'and return to home page' do
    visit root_path
    click_on 'Promoções'
    click_on 'Voltar'

    expect(page).to have_current_path root_path, ignore_query: true
  end

  it 'and return to promotions page' do
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'
    click_on 'Voltar'

    expect(page).to have_current_path promotions_path, ignore_query: true
  end
end
