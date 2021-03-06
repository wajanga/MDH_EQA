MDHEqa::Application.routes.draw do
  resources :facilities do
    get :autocomplete_district_name, :on => :collection
    collection { post :import }
    collection { get :reset_filterrific }
    member do
      get :new_sample
    end
  end
  resources :results do
    collection { post :check_facility }
    collection { post :check_eqa }
  end
  resources :sent_samples
  resources :eqa_tests
  resources :sessions, only: [:new, :create, :destroy]
  root  'sessions#new'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/demo', to: 'demo_pages#home',     via: 'get'
  match '/result_page', to: 'results#show',     via: 'get'
  match '/samples',   to: 'demo_pages#samples',   via: 'get'
  match '/reports', to: 'reports#index', via: 'get'
  match '/reports_reset', to: 'reports#reset_filterrific', via: 'get'
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
