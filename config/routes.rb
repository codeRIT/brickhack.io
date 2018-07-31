# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  # Pages
  get '/apilist', to: 'home#apilist'
  get '/design_category', to: 'home#design_category'
  get '/comingsoon', to: 'home#comingsoon'
  get '/home', to: 'home#index'

  # Homepage

  # root to: 'home#index'
  root to: 'home#comingsoon'
end
