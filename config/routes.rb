Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'search#index'
  get "/confirmation_success", to: "search#confirmation"
  get "/terms_conditions", to: "search#terms"
  get "/set_local", to: "search#set_local"

  mount ActionCable.server => '/cable'

  get 'search', to: 'search#index'
  post 'search', to: 'search#search'

  resource :user_info, path: 'account', except: [:destroy]
  resource :instructor_info, path: 'instructor', only: [:new, :create, :edit, :update, :destroy] do
    collection do
      get 'states'
      get 'cities'
      get 'schools_applied'
    end
  end

  get 'mentors', to: "instructor_infos#index"

  resources :profiles, only: [:show]
  resources :consult_transactions, path: 'transactions', except: [:edit, :new]
  post 'transactions/:id/confirm', to: 'consult_transactions#confirm', as: 'confirm_consult_transaction'
  post 'transactions/:id/pay', to: 'consult_transactions#pay', as: 'pay_consult_transaction'
  post '/alipay', to: 'consult_transactions#alipay'
  post '/alipay/:consult_tx_id', to: 'consult_transactions#alipay_callback', as: 'alipay_callback'
  resources :chat_lines, only: [:create]
  resources :payments, only: [:show, :update]
  resources :attachments, only: [:create, :destroy]
  resources :messages, only: [:index, :create]

  devise_for :users, path: 'users/security', controllers: {
    passwords: 'users/security/passwords',
    registrations: 'users/security/registrations',
    sessions: 'users/security/sessions',
    confirmations: 'users/security/confirmations'
  }

end
