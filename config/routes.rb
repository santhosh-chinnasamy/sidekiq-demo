require 'sidekiq/web'
# Configure Sidekiq-specific session middleware
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_session"

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  resources :posts do
    collection do
      post :bulk_create_without_worker
      post :bulk_create
      post :bulk_create_v2
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
