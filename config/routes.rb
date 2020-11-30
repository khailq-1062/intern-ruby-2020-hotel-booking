Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/cate/:slug", to: "rooms#index"
  end
end
