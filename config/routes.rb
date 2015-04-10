Rails.application.routes.draw do


  root 'articles#index'


  resources :articles do
    member do
      post 'favorite'
      delete 'favorite_destroy'
    end

    collection do
      get 'favorites'
    end

    resources :comments
  end


  devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
  }

  resources :users, :only => [:index, :show, :destroy] do
    member do
      post 'follow'
      delete 'follow_destroy'
      get 'follow_list'
      get 'follower_list'
      get 'my_articles'
    end
  end


  # devise_scope :user do
  #   get '/users/sign_out' => 'users/sessions#destroy'
  # end

  devise_for :admins, :controllers => {
      :registrations => 'admins/registrations',
      :sessions => 'admins/sessions'
  }

  resources :admins, :only => [:index]


#deviseのログアウトをlogin_user,admin_userを分けようと試みたが一旦保留#
  # devise_for :users, skip: [:sessions]
  # devise_scope :user do
  #   get 'login' => 'user/sessions#new', as: :new_user_session
  #   post 'login' => 'user/sessions#create', as: :user_session
  #   get 'logout' => 'user/sessions#destroy', as: :destroy_user_session
  # end

  # devise_scope :user do
  #   get "sign_in", to: "user/sessions#new"
  #   get "sign_out", to: "user/sessions#destroy"
  # end


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
