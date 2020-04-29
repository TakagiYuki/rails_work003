Rails.application.routes.draw do

  devise_for :users

  resources :books
  resources :users

  get 'home/about'

  root to:'home#top'

end

