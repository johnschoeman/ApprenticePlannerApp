Rails.application.routes.draw do
  get '/pages/*id' => 'pages#show', format: false

  resources :entries
  root to: 'pages#show', id: 'home'
end
