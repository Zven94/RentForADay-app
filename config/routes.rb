Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :destroy] do
        resources :appointments, only: [:index, :create, :destroy]
      end
      resources :items, only: [:index, :create, :destroy]
    end
  end
end
