Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "search" => "searches#search"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
      #ﾌｫﾛｰ機能 (ネストさせる)
    resource :relationships, only: [:create, :destroy]
      get :followings, on: :member #params[:id]にできる(付けない場合はparams[user_id])
      get :followers, on: :member
    #get 'followings' => 'relationships#followings', as: 'followings'
    #get 'followers' => 'relationships#followers', as: 'followers'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end