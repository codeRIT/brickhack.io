# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  get "/event", to: "home#event"
  get "home/index"
  get "/design_category", to: "home#design_category"
<<<<<<< HEAD
  get "/api_list", to: "home#api_list"
=======
>>>>>>> 8a122f0c100dceb953578f3c45ba95bd63a4cd89

  root to: 'home#index'
end
