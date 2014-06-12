GracehrabiCom::Application.routes.draw do

  root to: "blocks#home"

  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get 'news', to: 'posts#index', as: :news_index
  get 'news/:id', to: 'posts#show', as: :news
  get 'rss.:format', to: 'posts#rss'

  [:about, :gallery].each do |block|
    get block.to_s, to: "blocks##{block}"
  end
  get 'bio' => redirect('about')

  get 'music' => 'lyrics#index', as: :music
  get 'lyrics/:id' => 'lyrics#show', as: :lyric

  get 'download/:token/*filename', to: 'downloads#download', format: false, as: 'download'

  resources :events, only: [:index, :show] do
    collection do
      get :archive
    end
  end
  get 'events/calendar/:year/:month', to: 'events#index'
  resources :mailing_list, only: [:create, :show, :destroy]
  resources :mailing_list_mobile, only: [:index, :create]

  get 'unsubscribe/:id', to: 'mailing_list#show', as: "unsubscribe"

  resources :webhooks, only: [:create]
end
