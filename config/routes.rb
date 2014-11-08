Rails.application.routes.draw do
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
