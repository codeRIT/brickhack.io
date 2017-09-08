# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  get "/event", to: "home#event"
  get "home/index"
  get "/design_category", to: "home#design_category"
#  root to: 'home#index'
  root to: 'home#comingsoon'
end
