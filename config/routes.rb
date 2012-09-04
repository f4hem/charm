Charm::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.


  match 'charm/authorize', to: 'charm#authorize', as: :charm_authorize, via: [:get, :post]
  match 'charm/authorize_accept', to: 'charm#authorize_accept', as: :charm_authorize_accept, via: [:get, :post]

  match 'charm/token', to: 'charm#obtain_token', as: :charm_obtain_token, via: [:get, :post]
  match 'charm/inspect_token', to: 'charm#inspect_token', as: :charm_inspect_token, via: [:get, :post]


  resources :clients

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root to: 'welcome#index'

  # Sample of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action.

  # Sample of named route:
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  # This route can be invoked with purchase_url(id: product.id).

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


  # See how all your routes lay out with "rake routes".
end
