Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      scope 'auth' do
        post 'sign-up', to: 'users#create'
        post 'sign-in', to: 'users#sign_in'
        get 'auto-login', to: 'users#auto_login'
      end
    end
  end
end
