# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/users', controllers: {
    registrations: 'api/v1/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :sign_in, only: %i[index]
      resources :posts, only: %i[index show create destroy] do
        resources :comments, only: %i[index], to: 'posts#post_comment', controller: 'posts'
        resources :reposts, only: %i[create destroy]
      end
      post 'images', to: 'posts#attach_images'
      resources :search, only: %i[index]
      resources :users, only: %i[index show update destroy]
      resources :profile, only: %i[update]
      resources :comments, only: %i[create destroy]
    end
  end
end
