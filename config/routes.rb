# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :promotions do
    post 'generate_coupons', on: :member
  end
  resources :product_categories, only: %i[index show new create]

  resources :coupons, only: [] do
    post 'inactivate', on: :member
    post 'reactivate', on: :member
  end

  namespace 'api' do
    namespace 'v1' do
      get 'coupons/:code', to: 'coupons#show'
      post 'coupons/:code/burn', to: 'coupons#burn'
    end
  end
end
