Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root to: "static_pages#home"

    get "/categories/:slug/rooms", to: "rooms#index"
    get "/room/:slug", to: "rooms#show", as: "room"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/search", to: "search#index"
    get "categories", to: "categories#index"
    resources :users, except: %i(index destroy)
  end
end
