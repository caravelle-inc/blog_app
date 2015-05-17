Rails.application.routes.draw do

  root 'articles#index'

  resources :articles do
    resources :comments
  end

  resources :favorites, :only => [:destroy] do
    member do
      post 'favorite'
      get 'favorite_list'
    end
  end

  devise_for :users, :controllers => {
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
  }

  resources :users, :only => [:index, :show, :destroy] do
    member do
      get 'user_articles'
    end
  end

  resources :friendships, :only => [] do
    member do
      post 'follow'
      delete 'unfollow'
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