# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  # Pages
  get '/apilist', to: 'pages#apilist'
  get '/design_category', to: 'pages#design_category'
  get '/comingsoon', to: 'pages#comingsoon'
  get '/home', to: 'pages#index'

  # Homepage

  # root to: 'pages#index'
  root to: 'pages#comingsoon'
end
