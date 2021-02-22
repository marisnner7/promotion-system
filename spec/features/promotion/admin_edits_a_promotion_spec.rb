# frozen_string_literal: true

require 'rails_helper'

describe Promotion do
  before do
    user = create(:user)
    login_as(user, scope: :user)
    create(:promotion)
  end

  it 'sucessfully' do
    visit promotions_path
    click_on 'Natal'
    click_on 'Editar'

    within('.container') do
      fill_in 'Nome', with: 'Natal 2021'
      fill_in 'Descrição', with: 'Promoção de Natal 2021'

      click_on 'Editar promoção'
    end

    expect(page).to have_content('Natal 2021')
    expect(page).to have_content('Promoção de Natal 2021')
    expect(page).to have_content('NATAL10')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_link('Voltar')
  end
end
