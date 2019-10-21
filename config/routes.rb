Rails.application.routes.draw do
  resources :albums
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users

  unauthenticated :user do
    devise_scope :user do
      root to: 'devise/sessions#new'
    end
  end
  authenticated :user do
    root to: "users#index", as: 'unauthenticated_root'
  end
  resource :users, only: :index

end
