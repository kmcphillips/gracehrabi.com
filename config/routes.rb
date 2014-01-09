GracehrabiCom::Application.routes.draw do

  root to: "blocks#home"

  ActiveAdmin.routes(self)

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get 'news', to: 'posts#index'
  get 'news/:id', to: 'posts#show'
  get 'rss.:format', to: 'posts#rss'

  [:bio, :gallery].each do |block|
    get block.to_s, to: "blocks##{block}"
  end

  resources :events, only: [:index, :show]
  resources :mailing_list, only: [:create, :show, :destroy]
  resources :mailing_list_mobile, only: [:index, :create]

  get 'unsubscribe/:id', to: 'mailing_list#show', as: "unsubscribe"

end
