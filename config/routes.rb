Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'pages#home'
  get :connect, to: 'pages#connect', as: :connect
  get 'profile/:slug', to: 'pages#profile', as: :profile
end
