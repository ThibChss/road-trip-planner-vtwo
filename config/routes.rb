Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root 'pages#home'
  get :connexion, to: 'pages#connexion', as: :connexion
  get 'profile/:id', to: 'pages#profile', as: :profile
end
