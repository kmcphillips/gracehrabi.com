GracehrabiCom::Application.routes.draw do

  # news
  root :to => "posts#index"
  match 'news/:id' => 'posts#show'
  match 'rss.:format' => 'posts#rss'

  # blocks
  ['contact', 'links', 'bio'].each do |block|
    match block => "blocks##{block}"
  end

  # media player
  match 'player/:id' => 'tracks#show'

  resources :events, :only => [:index, :show]
  resources :galleries, :only => [:index, :show]
  resources :mailing_list, :only => [:index, :create]

  # admin
  namespace :admin do
    match 'login' => 'sessions#new'
    match 'logout' => 'sessions#logout'

    root :to => "posts#index"
    
    resources :sessions do
      collection do
        get 'password'
        post 'change_password'
      end
    end

    resources :blocks, :except => [:destroy, :create, :new, :show]
    resources :medias, :only => [:edit, :update]
    resources :events, :except => [:show]
    resources :links, :except => [:show] do
      collection { post 'sort'}
    end
    resources :posts, :except => [:show]
    resources :tracks, :except => [:show] do
      collection { post 'sort'}
    end
    resources :galleries, :only => [:index, :show]
    resources :images, :only => [:create, :destroy, :update] do
      collection { post 'sort'}
    end

    match :emails, :to => "blocks#emails"

  end
end
