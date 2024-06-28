Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationshops, only: [:create, :destroy]
    get 'followings' => 'relationshops#followings', as: 'followings'
    get 'followers' => 'relationshops#followers', as: 'followers'
  end
  
  get '/search' => 'searches#search'
  
  get 'chats/:id' => 'chats#show', as: 'chat'
  post 'chats/:id' => 'chats#create', as: 'new_chat'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
