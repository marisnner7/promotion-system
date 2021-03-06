# frozen_string_literal: true

require 'rails_helper'

describe 'Visitor visit home page' do
  it 'successfully' do
    visit root_path

    expect(page).to have_content('Promotion System')
    expect(page).to have_content('Boas vindas ao sistema de gestão de '\
                                 'promoções')
  end
end
