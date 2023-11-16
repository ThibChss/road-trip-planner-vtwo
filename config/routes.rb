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
  scope 'profile/:id' do
    get 'friends', to: 'friends#friends', as: :friends
    get 'pending_friends', to: 'friends#pending_friends', as: :pending_friends
    get 'invitations', to: 'friends#invitations', as: :invitations
    get 'search_friends', to: 'friends#search_friends', as: :search_friends
  end

  # Friendships controller routes
  resources :friendships, only: %i[create destroy]
  delete 'friendship/:id', to: 'friendships#remove', as: :remove_invitation
  delete :mutual_friendship, to: 'friendships#remove_mutual', as: :remove_mutual_friendship

  # Trips controller routes
  scope 'profile/:id' do
    get 'trips', to: 'trips#index', as: :trips_index
    resources :trips, only: %i[new create]
  end

  resources :trips, only: %i[show] do
    member do
      get :calendar
    end
  end
end
