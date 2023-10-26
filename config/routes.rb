Rails.application.routes.draw do

  # Devise custom logics
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }


  # Pages controller routes
  root 'pages#home'
  get :connect, to: 'pages#connect', as: :connect
  get 'profile/:id', to: 'pages#profile', as: :profile


  # Friends controller routes
  get 'profile/:id/friends', to: 'friends#friends', as: :friends
  get 'profile/:id/pending_friends', to: 'friends#pending_friends', as: :pending_friends
  get 'profile/:id/invitations', to: 'friends#invitations', as: :invitations
  get 'profile/:id/search_friends', to: 'friends#search_friends', as: :search_friends


  # Friendships controller routes
  resources :friendships, only: %i[create destroy]
  delete 'friendship/:id', to: 'friendships#remove', as: :remove_invitation
  delete :mutual_friendship, to: 'friendships#remove_mutual', as: :remove_mutual_friendship


  # Trips controller routes
  get 'profiel/:id/trips', to: 'trips#trips'
  resources :trips, only: %i[show new create]

end
