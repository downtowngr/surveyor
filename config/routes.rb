Rails.application.routes.draw do
  get 'dispatch' => "dispatch#trigger"

  scope '/admin' do
    root to: 'polls#index'
    devise_for :users
    resources :users
    resources :polls do
      resources :poll_choices
    end
    resources :citizens
    resources :listeners, only: [:index]
  end
end
