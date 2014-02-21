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

  resources :events, only: [:index, :show] do
    collection do
      get :archive
    end
  end
  resources :mailing_list, only: [:create, :show, :destroy]
  resources :mailing_list_mobile, only: [:index, :create]

  get 'unsubscribe/:id', to: 'mailing_list#show', as: "unsubscribe"

end
