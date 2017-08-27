Rails.application.routes.draw do

  root 'home#index'

  get 'users/show/:id', :to => 'users#show', :as => 'user'

  get 'account', :to => 'account#index'

  devise_for :users
end
