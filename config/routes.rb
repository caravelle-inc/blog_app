Rails.application.routes.draw do

  root 'articles#index'

  resources :articles do
    collection do
      get 'my_articles'
    end

    resources :comments
  end

  resources :favorites, :only => [:destroy] do
    member do
      post 'favorite'
    end

    collection do
      get 'favorite_list'
    end
  end

  devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
  }

  resources :users, :only => [:index, :show, :destroy]

  resources :friendships, :only => [] do
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
