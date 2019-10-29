Rails.application.routes.draw do
  scope as: :auth, path: '' do
    mount_devise_token_auth_for 'User', at: 'auth'
  end
  resources :albums
  apipie
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  get :api, to: redirect("/swagger/index.html?url=#{CGI.escape '/apidoc.json?type=swagger'}")

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
