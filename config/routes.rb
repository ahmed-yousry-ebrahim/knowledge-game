Rails.application.routes.draw do
  resources :home do
    collection do
      get "select_category"
      get "game_over"
    end
  end
  resources :questions do
    collection do
      get "random"
    end
    member do
      get "solve"
    end
  end
  post '/', to: 'home#index'
  root 'home#index'

end
