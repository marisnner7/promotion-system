# frozen_string_literal: true

require 'rails_helper'

describe User do
  context 'e-mail validation' do
    it 'must be at domain @locaweb.com.br' do
      user = create(:user)
      user.valid?

      expect(user.errors.of_kind?(:email, :invalid)).to be(false)
    end

    it 'and it is invalid' do
      user = User.new(email: 'joao@gmail.com', password: '123456')

      user.valid?

      expect(user.errors.of_kind?(:email, :invalid)).to be(true)
    end
  end
end
