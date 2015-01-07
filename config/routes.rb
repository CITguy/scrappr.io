Rails.application.routes.draw do
  # Omniauth-ONLY login scheme
  devise_for :users, controllers: { omniauth_callbacks: "user_sessions" }
  devise_scope :user do
    delete "logout" => "user_sessions#destroy"
  end

  ## UI Routes
  resources :users, only: :none do
    scope module: :users do
      resources :scraps do
        member do
          get :raw
        end
      end
    end
  end
  ## User-API Routes
  scope module: "users/api", as: :user_api do
    match ":user_id/api/*endpoint" => "scraps#show", via: :all, as: :endpoint
  end

  namespace :api do
    resources :users, only: [:update]
  end

  namespace :help do
    get :liquid_variables
  end

  scope module: "public_pages" do
    get :status
  end

  root to: "public/scraps#index"
end
