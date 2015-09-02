Rails.application.routes.draw do
  

  get 'password_resets/new'

  get 'password_resets/edit'

  #Routes for our pages:
  root              'static_pages#home'
  get 'help'    =>  'static_pages#help'
  get 'about'   =>  'static_pages#about'
  get 'contact' =>  'static_pages#contact'
  get 'signup'  =>  'users#new'
  
  #routes for our sessions controller
  #do not need the resources :session route
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  
  #"resources" provides all REST links for our resource... User
  #The bellow also arranges to have /users/1/following and /.../followers
  #member method arranges for the routes to respond to URLs containing user id.
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  #Only provides the actions listed
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  
  #Since all micropost interfacing is done through the user profile,
  #we then don't need :edit/:new/:etc...
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  
  


  #----------------------------------------
  #-------auto generated stuff-------------
  #----------------------------------------
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  

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
