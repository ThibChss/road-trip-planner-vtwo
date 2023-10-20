Rails.application.routes.draw do

  # Devise custom logics
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Friends routes
  root 'pages#home'
  get :connect, to: 'pages#connect', as: :connect
  get 'profile/:slug', to: 'pages#profile', as: :profile

  # Friends controller routes
  get 'profile/:slug/friends', to: 'friends#friends', as: :friends
  get 'profile/:slug/pending_friends', to: 'friends#pending_friends', as: :pending_friends
  get 'profile/:slug/invitations', to: 'friends#invitations', as: :invitations
  get 'profile/:slug/search_friends', to: 'friends#search_friends', as: :search_friends

  # Friendships routes
  resources :friendships, only: %i[create destroy]
end
