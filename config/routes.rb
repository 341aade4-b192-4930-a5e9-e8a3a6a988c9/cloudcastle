Rails.application.routes.draw do
  resources :users
  get ':action' => 'home#:action'
  root controller: :home, action: :home
end
