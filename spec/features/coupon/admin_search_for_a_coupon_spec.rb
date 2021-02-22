require 'rails_helper'

feature 'Admin searches for coupon' do
    scenario 'successfully' do
        promotion = Promotion.create!(name: 'Cyber Monday', 
                                      coupon_quantity: 100,
                                      description: 'Promoção de Cyber Monday',
                                      code: 'CYBER15', discount_rate: 15,
                                      expiration_date: '22/12/2033')
        promotion.coupons.create!(code: 'PAS0001', status: :active)
        promotion.coupons.create!(code: 'PAS0002', status: :active)
        user = User.create!(email: 'janedoe@locaweb.com.br', password: '123456')

        login_as user, scope: :user
        visit root_path
        fill_in 'coupons_query', with: 'PAS0001'
        click_on 'Buscar cupom'

        expect(current_path).to eq(coupons_path)
        expect(page).to have_content('PAS0001')
        expect(page).to_not have_content('PAS0002')
    end

    scenario 'and coupon not found' do
        promotion = Promotion.create!(name: 'Cyber Monday', 
            coupon_quantity: 100,
            description: 'Promoção de Cyber Monday',
            code: 'CYBER15', discount_rate: 15,
            expiration_date: '22/12/2033')
        promotion.coupons.create!(code: 'PAS0001', status: :active)
        promotion.coupons.create!(code: 'PAS0002', status: :active)
        user = User.create!(email: 'janedoe@locaweb.com.br', password: '123456')

                login_as user, scope: :user
                visit root_path
                fill_in 'coupons_query', with: 'PAS0007'
                click_on('Buscar cupom')

                expect(current_path).to eq(coupons_path)
                expect(page).to_not have_content('PAS0001')
                expect(page).to_not have_content('PAS0002')
                expect(page).to_not have_content('PAS0007')
                expect(page).to have_content('Nenhum cupom encontrado')
        end
    end