Rails.application.routes.draw do
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  root to: redirect("/api-docs")

  namespace :api do
    namespace :v1 do
      get "first-load-resources", to: "resources#load"

      scope "auth" do
        post "sign-up", to: "users#create"
        post "sign-in", to: "users#sign_in"
        get "auto-login", to: "users#auto_login"
      end

      resources :categories, only: %w[create update destroy]
      resources :posts, only: %w[index create update destroy]
    end
  end
end
