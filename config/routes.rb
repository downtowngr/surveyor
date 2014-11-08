Rails.application.routes.draw do
  get 'pages/index'

  devise_for :users

  root 'pages#index'

end
