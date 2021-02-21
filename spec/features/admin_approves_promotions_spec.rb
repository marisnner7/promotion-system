require 'rails_helper'

feature 'Admin approves promotions' do
  scenario 'sucessfully' do
    promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                      description: 'Promoção de segunda!',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')
    
    creator = create(:user)
    promotion = creator.id
    approver = create(:user, email: 'johndoe@locaweb.com.br', password: '123456')

    login_as approver, scope: :user
    visit promotions_path
    click_on 'Cyber Monday'
    click_on 'Aprovar promoção'

    expect(page).to have_content('Promoção aprovada')
    expect(page).to have_content('Gerar cupons')
    expect(page).to_not have_content('Aprovar promoção')
  end

  scenario 'but creator cant approve' do
    promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                  description: 'Promoção de segunda!',
                                  code: 'CYBER15', discount_rate: 15,
                                  expiration_date: '22/12/2033')
    creator = User.create!(id: 1, email: 'janedoe@locaweb.com.br', password: '123456')
    promotion.update(creator_id: creator.id)

    login_as creator, scope: :user
    visit promotion_path(promotion)

    expect(page).to have_content('Aguardando aprovação')
    expect(page).to_not have_content('Aprovar promoção')
    expect(page).to_not have_content('Gerar cupons')
  end
end