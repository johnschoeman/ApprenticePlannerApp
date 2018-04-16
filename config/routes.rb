Rails.application.routes.draw do
  get "/pages/*id" => "pages#show", format: false

  resources :entries do
    resources :notes, only: %i(create update)
  end
  root to: "pages#show", id: "home"
end
