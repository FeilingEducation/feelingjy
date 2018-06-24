Rails.application.routes.draw do


  resources :universities do
    resources :departments
  end

  post 'results', to: 'universities#results'


  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'search#index'
  get "/confirmation_success", to: "search#confirmation"
  get "/terms_conditions", to: "search#terms"
  get "/set_local", to: "search#set_local"

  get "/seeds", to: "application#data"

  resources :user_wallets
  resources :user_wallet_activities

  mount ActionCable.server => '/cable'

  get 'search', to: 'search#index'
  post 'search', to: 'search#search'

  get 'efficiency-tool', to: "search#efficiency_tool"

  resource :user_info, path: 'account', except: [:destroy] do
    member do
      get 'show_student'
      get 'show_instructor'
    end
    collection do
      put "update_password"
    end
  end

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
  # post 'transactions/:id/confirm', to: 'consult_transactions#confirm', as: 'confirm_consult_transaction'
  get 'transactions/:id/confirm', to: 'consult_transactions#confirm', as: 'confirm_consult_transaction'
  get 'transactions/:id/decline', to: 'consult_transactions#decline', as: 'decline_consult_transaction'
  get 'transactions/:id/payment_complete', to: 'consult_transactions#payment_complete', as: 'payment_complete_consult_transaction'
  get 'transactions/:id/complete', to: 'consult_transactions#complete', as: 'complete_consult_transaction'


  post 'transactions/:id/pay', to: 'consult_transactions#pay', as: 'pay_consult_transaction'
  post '/alipay', to: 'consult_transactions#alipay'
  post '/alipay/:consult_tx_id', to: 'payments#alipay_callback', as: 'alipay_callback'
  get '/payment_success/:consult_tx_id', to: 'payments#payment_confirmation', as: 'payment_success'
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

  resources :users do
    resources :reviews
  end
end
