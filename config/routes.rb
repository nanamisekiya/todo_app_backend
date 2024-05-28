Rails.application.routes.draw do
  resources :tasks do
    member do
      post 'start_timer'
      patch 'stop_timer'
    end
  end
end
