# frozen_string_literal: true

require 'rails_helper'

describe Promotion do
  before do
    user = create(:user)
    login_as(user, scope: :user)
  end

  it 'from index page' do
    visit root_path
    click_on 'Promoções'

    expect(page).to have_link('Registrar uma promoção',
                              href: new_promotion_path)
  end

  it 'successfully' do
    create(:product_category)
    create(:product_category, name: 'E-mail', code: 'EMAIL')
    create(:product_category, name: 'Cloud', code: 'CLOUD')

    visit root_path
    click_on 'Promoções'
    click_on 'Registrar uma promoção'

    within('.container') do
      fill_in 'Nome', with: 'Cyber Monday'
      fill_in 'Descrição', with: 'Promoção de Cyber Monday'
      fill_in 'Código', with: 'CYBER15'
      fill_in 'Desconto', with: '15'
      fill_in 'Quantidade de cupons', with: '90'
      # fill_in 'Data de término', with: '22/12/2033'
      check 'Hospedagem'
      check 'E-mail'
      click_on 'Criar promoção'
    end

    # expect(current_path).to eq(promotion_path(Promotion.last))
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('90')
    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('E-mail')
    expect(page).not_to have_content('Cloud')
    expect(page).to have_link('Voltar')
  end
end
