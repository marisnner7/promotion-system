require 'rails_helper'

feature 'Admin registers a promotion' do
  before(:each) do
    
    user = create(:user)
    login_as(user, scope: :user)

  end

  
  scenario 'from index page' do
    visit root_path

    click_on 'Categorias de produto'

    expect(page).to have_link('Registrar categoria de produto',
                              href: new_product_category_path)
  end
end