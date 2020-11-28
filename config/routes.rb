Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/categories/:slug/rooms", to: "rooms#index"
    get "/room/:slug", to: "rooms#show", as: "room"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/search", to: "search#index"
  end
end
