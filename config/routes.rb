Rails.application.routes.draw do

  root 'search#index'

  mount ActionCable.server => '/cable'

  get 'search', to: 'search#index'

  resource :user_info, path: 'account', except: [:destroy]
  get 'account/messages', to: 'user_infos#messages', as: 'messages'
  resource :instructor_info, path: 'instructor', only: [:new, :create, :edit, :update, :destroy]
  resources :profiles, only: [:show]
  resources :consult_transactions, path: 'transactions', except: [:edit, :new]
  post 'transactions/:id/confirm', to: 'consult_transactions#confirm', as: 'confirm_consult_transaction'
  post 'transactions/:id/pay', to: 'consult_transactions#pay', as: 'pay_consult_transaction'
  resources :chat_lines, only: [:create]
  resources :payments, only: [:show, :update]
  resources :attachments, only: [:create, :destroy]
  resources :messages, only: [:index, :create]

  devise_for :users, path: 'users/security', controllers: {
    passwords: 'users/security/passwords',
    registrations: 'users/security/registrations',
    sessions: 'users/security/sessions'
  }

end
