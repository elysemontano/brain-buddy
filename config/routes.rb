Rails.application.routes.draw do
  devise_for :users,
  path: '',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

authenticated :user do
  get '/users/current_user', to: 'users#current_user'
end
  resources :cards
  resources :topics
  resources :apartments
end