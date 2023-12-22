# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/users', controllers: {
    registrations: 'api/v1/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :sign_in, only: %i[index]
      resources :tweets, only: %i[index  show  create destroy]
      post 'images', to: 'tweets#attach_images'
    end
  end

end
