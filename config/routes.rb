Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      scope 'auth' do
        post 'sign-up', to: 'users#create'
      end
    end
  end
end
