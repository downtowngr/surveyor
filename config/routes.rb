Rails.application.routes.draw do
  get 'pages/index'
  get 'dispatch' => "dispatch#trigger"

  devise_for :users

  root 'pages#index'

  scope '/admin' do
    root to: 'polls#index'
    devise_for :users
    resources :users
    resources :polls do
      resources :poll_choices
    end
    resources :citizens
  end
end
