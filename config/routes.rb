Rails.application.routes.draw do

  root 'home#index'

  get 'debug', to: 'debug#index'

  namespace :users do
    resources :profiles, only: [:show]
  end

  resource :user_info, path: 'account', except: [:destroy]
  resource :instructor_info, path: 'instructor'
  resources :consult_transactions, path: 'transactions', except: [:edit]

  devise_for :users, path: 'users/security', controllers: {
    passwords: 'users/security/passwords',
    registrations: 'users/security/registrations',
    sessions: 'users/security/sessions'
  }

end
