Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: %i(new create show)
    resource :static_pages do
      collection do
        get "/home", to: "static_pages#home"
        get "/contact", to: "static_pages#contact"
        get "/help", to: "static_pages#help"
      end
    end
  end
end
