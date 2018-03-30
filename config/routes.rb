Rails.application.routes.draw do
  get '/pages/*id' => 'pages#show', format: false

  resources :entries, only: [:new, :create, :show]
  root to: 'pages#show', id: 'home'
end
