# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  # Pages
  get '/apilist', to: 'home#apilist'
  get '/design_category', to: 'home#design_category'
  get '/comingsoon', to: 'home#comingsoon'
  # get '/', to: 'home#index' is taken care of by "root" below

  # Homepage
<<<<<<< HEAD
   root to: 'home#index'
=======
  root to: 'home#index'
>>>>>>> ce21def0b82996f3a84c40c07fa4583aeaf6f969
  # root to: 'home#comingsoon'
end
