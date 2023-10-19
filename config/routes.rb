Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'pages#home'
  get :connect, to: 'pages#connect', as: :connect
  get 'profile/:slug', to: 'pages#profile', as: :profile
  get 'profile/:slug/friends', to: 'pages#friends', as: :friends
  get 'profile/:slug/pending_friends', to: 'pages#pending_friends', as: :pending_friends
  get 'profile/:slug/invitations', to: 'pages#invitations', as: :invitations
  get 'profile/:slug/search_friends', to: 'pages#search_friends', as: :search_friends
end
