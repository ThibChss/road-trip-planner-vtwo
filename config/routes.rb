Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'
  get :connexion, to: 'pages#connexion', as: :connexion
  get :profile, to: 'pages#profile', as: :profile
end
