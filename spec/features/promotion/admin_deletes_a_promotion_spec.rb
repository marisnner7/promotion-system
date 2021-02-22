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
    click_on 'Deletar promoção'

    expect(page).not_to have_content('Natal')
    expect(page).to have_content('Promoção deletada com sucesso')
  end
end
