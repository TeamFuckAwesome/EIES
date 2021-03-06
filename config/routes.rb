Rails.application.routes.draw do
  root 'sessions#new'
  post 'login' => 'sessions#create'
  get  'login' => 'sessions#new'
  get  'home'  => 'sessions#create'
  delete 'login' => 'sessions#destroy'

  resources :users, except: [:destroy]
  resources :entity_tokens, except: [:update]
  resources :entities
  resources :keys

  get "/404" => "errors#not_found"
  get "/500" => "errors#exception"

  # API v1
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post 'login' => 'sessions#create'
      delete 'login' => 'sessions#destroy'
      get 'public_keys' => 'keys#get'
      resources :users, only: [:show]
      resources :entities, only: [:create, :update, :show, :destroy]
      resources :entity_tokens, only: [:create, :show, :destroy]
      resources :keys, only: [:create, :update, :show, :destroy]
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
