# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  # Pages
  get '', to: 'pages#thankyou'
  get '/live', to: 'pages#live'
  get '/comingsoon', to: 'pages#comingsoon'
  get '/home', to: 'pages#thankyou'
  get '/thankyou', to: 'pages#thankyou'

  # Homepage

  # root to: 'pages#index'
  root to: 'pages#index'
end
