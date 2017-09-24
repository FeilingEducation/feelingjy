Rails.application.routes.draw do

  root 'home#index'

  mount ActionCable.server => '/cable'

  get 'search', to: 'search#index'
  get 'debug', to: 'debug#index'

  resources :profiles, only: [:show]

  resource :user_info, path: 'account', except: [:destroy]
  resource :instructor_info, path: 'instructor'
  resources :consult_transactions, path: 'transactions', except: [:edit]
  resources :chat_lines, only: [:create]

  devise_for :users, path: 'users/security', controllers: {
    passwords: 'users/security/passwords',
    registrations: 'users/security/registrations',
    sessions: 'users/security/sessions'
  }

end
