# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes a promotion' do
  before(:each) do
    user = create(:user)
    login_as(user, scope: :user)
    create(:promotion)
  end

  scenario 'sucessfully' do
    visit promotions_path
    click_on 'Natal'
    click_on 'Deletar promoção'

    expect(page).to_not have_content('Natal')
    expect(page).to have_content('Promoção deletada com sucesso')
  end
end
