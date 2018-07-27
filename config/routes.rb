Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :imports, only: [:index, :show, :create, :new] do
    member do
      get :venues
      get :events
      get :places
      get :menus
    end
  end

  resources :menus, only: [:show]

  root to: 'root#redirect'
end
