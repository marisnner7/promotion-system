# frozen_string_literal: true

require 'rails_helper'

describe 'Admin registers a valid category' do
  before do
    user = create(:user)
    login_as(user, scope: :user)
    visit root_path

    click_on 'Categorias de produto'
    click_on 'Registrar categoria de produto'
    within('.container') do
      fill_in 'Nome', with: 'Hospedagem'
    end
  end

  it 'and attributes cannot be blank' do
    fill_in 'Código', with: ''
    click_on 'Criar categoria'

    expect(page).to have_content('não pode ficar em branco')
  end

  it 'and code must be unique' do
    create(:product_category)

    fill_in 'Código', with: 'HOSP'
    click_on 'Criar categoria'

    expect(page).to have_content('já está em uso')
  end
end
