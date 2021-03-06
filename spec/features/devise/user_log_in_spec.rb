# frozen_string_literal: true

require 'rails_helper'
context 'when user do registration' do
  it 'and log out' do
    user = create(:user)

    login_as(user)

    visit root_path

    expect(page).to have_content('Logout')
    expect(page).not_to have_content('Login')
  end

  it 'user can only login without the locaweb domain' do
    visit root_path
    click_on 'Login'
    click_on 'Sign up'
    fill_in 'Email', with: 'user@gmail.com.br'
    find('div.user_password').fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    within('.form-actions') do
      click_on 'Sign up'
    end

    expect(page).to have_content('deve ser do domínio locaweb')
  end
end
