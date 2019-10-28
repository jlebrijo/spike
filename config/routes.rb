Rails.application.routes.draw do
  scope as: :auth, path: '' do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
  resources :albums
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users

  unauthenticated :user do
    devise_scope :user do
      root to: 'devise/sessions#new'
    end
  end
  authenticated :user do
    root to: "albums#index", as: 'unauthenticated_root'
  end
  resource :users, only: :index

end
