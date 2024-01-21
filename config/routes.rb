Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      resources :ip_addresses, constraints: { id: /[^\/]+/ }, only: [:create, :show, :destroy]
      resources :domains, constraints: { id: /[^\/]+/ }, only: [:create, :show, :destroy]
    end
  end
end
