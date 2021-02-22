# frozen_string_literal: true

require 'rails_helper'

describe 'Admin registers a promotion' do
  before do
    user = create(:user)
    login_as(user, scope: :user)
  end

  it 'from index page' do
    visit root_path

    click_on 'Categorias de produto'

    expect(page).to have_link('Registrar categoria de produto',
                              href: new_product_category_path)
  end
end
