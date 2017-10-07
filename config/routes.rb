Rails.application.routes.draw do

  root 'search#index'

  mount ActionCable.server => '/cable'

  get 'search', to: 'search#index'
  get 'debug', to: 'debug#index'

  resource :user_info, path: 'account', except: [:destroy]
  resource :instructor_info, path: 'instructor', only: [:new, :create, :edit, :update, :destroy]
  resources :profiles, only: [:show]
  resources :consult_transactions, path: 'transactions', except: [:edit]
  post 'transactions/:id/confirm', to: 'consult_transactions#confirm', as: 'confirm_consult_transaction'
  post 'transactions/:id/pay', to: 'consult_transactions#pay', as: 'pay_consult_transaction'
  resources :chat_lines, only: [:create]
  resources :payments, only: [:show, :update]
  resources :attachments, only: [:create, :destroy]
  resources :messages, only: [:create]

  devise_for :users, path: 'users/security', controllers: {
    passwords: 'users/security/passwords',
    registrations: 'users/security/registrations',
    sessions: 'users/security/sessions'
  }

end
