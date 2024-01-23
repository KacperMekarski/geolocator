Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      resources :ip_addresses, constraints: { id: /[^\/]+/ }, only: [:create, :show, :destroy]
      post '/domains', to: 'domains#create'
      get '/domains', to: 'domains#show'
      delete '/domains', to: 'domains#destroy'
    end
  end
end
