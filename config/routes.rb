Rails.application.routes.draw do

  mount RedactorRails::Engine => '/redactor_rails'
  ActiveAdmin.routes(self)
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  
  root to: "articles#index"
  
  #FIXME
  resources :comments
  #FIXME
  get 'tag/:tag', to: 'articles#show_by_tag', as: :tag
  
  get 'articles/search', to: 'articles#search'
  resources :articles, only: [:index, :show, :new, :create, :update, :destroy]

  # resources :comments, only: [:create, :update, :destroy]

  # show articles by category
  get 'category/:name', to: 'categories#show'

  get 'subscribe_category/:name', to: 'categories#subscribe'

  get '/unsubscribe/:signature' => 'categories#unsubscribe', as: 'unsubscribe'




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
