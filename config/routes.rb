Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users do
      resources :microposts, only: %i(create destroy)
      member do
        get :following, :followers
      end
    end

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    resources :account_activations, only: :edit

    resources :password_resets, except: %i(index show destroy)

    resources :relationships, only: %i(create destroy)

    resource :static_pages do
      collection do
        get "/home", to: "static_pages#home"
        get "/contact", to: "static_pages#contact"
        get "/help", to: "static_pages#help"
      end
    end
  end
end
