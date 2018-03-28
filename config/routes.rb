Rails.application.routes.draw do
  get '/pages/*id' => 'pages#show', format: false

  root to: 'pages#show', id: 'home'
end
