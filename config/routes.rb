Rails.application.routes.draw do
  scope module: :public do
    get root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/customers/my_page' => 'customers#show'
    get 'customers/confirm'
    post 'orders/confirm'
    get 'orders/thanks'
    patch '/customers/quit' => 'customers#quit'
    resource :customers, only: [:edit, :update]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :orders,only:[:new, :index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end
  end
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
