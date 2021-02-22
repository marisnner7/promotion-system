# frozen_string_literal: true

require 'rails_helper'

feature 'Admin deletes a product category' do
  before(:each) do
    user = create(:user)
    login_as(user, scope: :user)
    create(:product_category)
    create(:product_category, name: 'Cloud', code: 'CLOU')

    
    
  end

  scenario 'sucessfully' do
    visit product_categories_path
    click_on 'Hospedagem'
    click_on 'Deletar Categoria'

    expect(page).to_not have_content('HOSP')
    expect(page).to have_content('Categoria deletada com sucesso')
  end
end
