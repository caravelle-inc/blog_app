Rails.application.routes.draw do


  root 'articles#index'


  resources :articles do
    member do
      post 'favorite'
      delete 'favorite_destroy'
    end

    collection do
      get 'favorite_list'
      get 'my_favorites'
      get "article_search"
      get 'my_articles'
    end

    resources :comments
  end


  devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
  }

  resources :users, :only => [:index, :show, :destroy]

  resources :friendships do
    member do
      post 'follow'
      delete 'unfollow'
    end
    collection do
      get 'follow_list'
      get 'follower_list'
    end
  end

  devise_for :admins, :controllers => {
      :registrations => 'admins/registrations',
      :sessions => 'admins/sessions'
  }

  resources :admins, :only => [:index]

  resources :searches, :only => [:index] do
    collection do
      get "search"
    end
  end

end
