Rails.application.routes.draw do
  get "dispatch" => "dispatch#trigger"
  get "/", to: redirect("/admin")

  scope "/admin" do
    root to: "polls#index"
    devise_for :users

    resources :users
    resources :polls do
      resources :poll_choices
    end
    resources :events
    resources :citizens, only: [:index, :show]
    resources :listeners, only: [:index]
  end
end
