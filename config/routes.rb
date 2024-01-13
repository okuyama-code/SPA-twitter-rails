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
        resource :repost, only: %i[create destroy]
        resource :likes, only: %i[create destroy]
        resource :bookmarks, only: %i[create destroy]
      end
      resources :bookmarks, only: %i[index]
      post 'images', to: 'posts#attach_images'
      resources :search, only: %i[index]
      resources :users, only: %i[index show update] do
        post 'follow', to: 'relationships#create'
        post 'unfollow', to: 'relationships#destroy'
      end
      post 'current_user/destroy', to: 'users#current_user_destroy'
      resources :profile, only: %i[update]
      resources :comments, only: %i[create destroy]
      resources :notifications, only: %i[index]
      resources :groups, only: %i[create index show] do
        resources :messages, only: %i[index create]
      end
      resource
    end
  end
end
