Rails.application.routes.draw do

  root 'home#index'

  namespace :users do
    resources :profiles, only: [:show]
  end

  resource :user_info, path: 'account', except: [:destroy]

  devise_for :users, path: 'users/security', controllers: {
    passwords: 'users/security/passwords',
    registrations: 'users/security/registrations',
    sessions: 'users/security/sessions'
  }

end
