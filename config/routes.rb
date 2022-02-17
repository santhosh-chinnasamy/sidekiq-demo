Rails.application.routes.draw do
  resources :posts do
    collection do
      post :bulk_create
      post :bulk_create_v2
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
