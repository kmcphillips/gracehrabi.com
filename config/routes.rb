GracehrabiCom::Application.routes.draw do

  root :to => "blocks#home"
  match 'news' => 'posts#index'
  match 'news/:id' => 'posts#show'
  match 'rss.:format' => 'posts#rss'

  ['contact', 'links', 'bio'].each do |block|
    match block => "blocks##{block}"
  end

  # media player
  match 'player/:id' => 'tracks#show'

  resources :events, only: [:index, :show]
  resources :galleries, only: [:index, :show]
  resources :mailing_list, only: [:index, :create, :show, :destroy]
  resources :mailing_list_mobile, only: [:index, :create]

  match 'unsubscribe/:id' => 'mailing_list#show', as: "unsubscribe"

  namespace :admin do
    match 'login' => 'sessions#new'
    match 'logout' => 'sessions#logout'

    root to: "posts#index"
    
    resources :sessions do
      collection do
        get 'password'
        post 'change_password'
      end
    end

    resources :blocks, except: [:destroy, :create, :new, :show]
    resources :medias, only: [:edit, :update]
    resources :events, except: [:show]
    resources :links, except: [:show] do
      collection do
        post 'sort'
      end
    end
    resources :posts, except: [:show]
    resources :tracks, except: [:show] do
      collection do
        post 'sort'
      end
    end
    resources :galleries, only: [:index, :show]
    resources :images, only: [:create, :destroy, :update] do
      collection do
        post 'sort'
      end
    end
    resources :contacts, only: [:index, :update, :create]
  end
end
