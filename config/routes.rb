# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  get "/event", to: "home#event"
  get "home/index"

  root to: 'home#index'
end
