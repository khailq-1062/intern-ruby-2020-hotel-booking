Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/cate/:slug", to: "rooms#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
end
