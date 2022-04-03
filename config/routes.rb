Rails.application.routes.draw do
  scope module: :public do
    get root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/customers/my_page' => 'customers#show'
    get 'customers/confirm'
    patch '/customers/quit' => 'customers#quit'
    resource :customers, only: [:edit, :update]
    resources :addresses, only: [:index, :create, :edit, :update]
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
