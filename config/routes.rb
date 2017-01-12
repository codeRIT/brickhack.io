# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  require 'sidekiq/web'

  devise_for :users, controllers: { registrations: "users/registrations", omniauth_callbacks: "users/omniauth_callbacks" }

  mount MailPreview => 'mail_view' if Rails.env.development?

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resource :questionnaires, path: "apply" do
    get :schools, on: :collection
  end

  resource :rsvp do
    get :accept, on: :collection
    get :deny, on: :collection
  end

  namespace :manage do
    root to: "dashboard#index"
    resources :dashboard do
      get :map_data, on: :collection
      get :todays_activity_data, on: :collection
      get :todays_stats_data, on: :collection
      get :confirmation_activity_data, on: :collection
      get :application_activity_data, on: :collection
      get :schools_confirmed_data, on: :collection
      get :user_distribution_data, on: :collection
      get :application_distribution_data, on: :collection
      get :schools_confirmed_data, on: :collection
      get :schools_applied_data, on: :collection
    end
    resources :questionnaires do
      post :datatable, on: :collection
      patch :check_in, on: :member
      patch :convert_to_admin, on: :member
      patch :update_acc_status, on: :member
      patch :bulk_apply, on: :collection
    end
    resources :admins do
      post :datatable, on: :collection
    end
    resources :messages do
      get :preview, on: :member
      post :datatable, on: :collection
      patch :deliver, on: :member
    end
    resources :bus_lists do
      post :toggle_bus_captain, on: :member
    end
    resources :schools do
      post :datatable, on: :collection
      get :merge, on: :member
      patch :perform_merge, on: :member
    end
    resources :stats do
      post :dietary_special_needs, on: :collection
      post :sponsor_info, on: :collection
      post :alt_travel, on: :collection
    end
  end

  resource :bus_list

  get "/event", to: "home#event"
  get "home/index"

  root to: 'home#index'
end
