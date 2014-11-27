Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  post "inbound" => "twilio_inbound#create"

  get "/", to: redirect("/admin")
  scope "/admin" do
    root to: "polls#index"
    devise_for :users

    resources :polls do
      resources :poll_choices
    end
    resources :events
    resources :blasts, except: [:destroy, :edit]

    resources :users
    resources :citizens, only: [:index, :show]
    resources :listeners, only: [:index]
  end
end
