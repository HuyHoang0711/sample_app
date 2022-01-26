Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    resource :static_pages do
      collection do
        get "/home", to: "static_pages#home"
        get "/contact", to: "static_pages#contact"
        get "/help", to: "static_pages#help"
      end
    end
  end
end
