Rails.application.routes.draw do
  get 'pages/index'

  devise_for :users

  root 'pages#index'

  scope '/admin' do
    resources :polls do
      resources :poll_choices
    end
    resources :citizens
  end
end
