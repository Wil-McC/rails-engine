Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'merchants/find', to: 'merchants#find'
      get 'revenue/merchants', to: 'merchants#most_revenue'
      get 'revenue/unshipped', to: 'invoices#unshipped_revenue'
      get 'revenue/merchants/:id', to: 'merchants#total_revenue'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: "merchant_items"
      end
      resources :items, only: [:index] do
        resources :merchant, only: [:index], controller: 'item_merchant'
      end
    end
  end
end
