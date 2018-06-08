Rails.application.routes.draw do
  resources :users
  get '*path' => 'home#show'
end
