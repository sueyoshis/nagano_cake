Rails.application.routes.draw do
  scope module: :public do
    get root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/customers/my_page' => 'customers#show'
    get 'customers/confirm'
    post 'orders/confirm'
    get 'orders/thanks'
    get 'search' => 'items#search'
    patch '/customers/quit' => 'customers#quit'
    resource :customers, only: [:edit, :update]
    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :create, :index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end
  end
  namespace :admin do
    get root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:new, :create, :index, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_items, only: [:update]
    end
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
