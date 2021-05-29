# frozen_string_literal: true

Rails.application.routes.draw do
  scope format: false do
    root to: 'home#index'
  end

  devise_for :user, path: '', controllers: { omniauth_callbacks: 'authentications' }
  devise_scope :user do
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  namespace :customers, format: false do
    root to: 'dashboard#index'
  end

  namespace :associates, format: false do
    root to: 'dashboard#index'
  end
end
