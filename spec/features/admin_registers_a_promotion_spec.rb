require 'rails_helper'

feature 'Admin registers a promotion' do
  #include_context 'When authenticated'

  before(:each) do
    
    user = create(:user)
    login_as(user, scope: :user)
    create(:promotion)

  end

  
  scenario 'from index page' do
    visit root_path
    click_on 'Promoções'

    expect(page).to have_link('Registrar uma promoção',
                              href: new_promotion_path)
  end
end
