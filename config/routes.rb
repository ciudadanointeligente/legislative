Legislative::Application.routes.draw do
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#login", :as => "log_in"
  post "auth" => "sessions#login"
  get "sign_up" => "users#new", :as => "sign_up"
  get "confirmed" => "user_subscriptions#confirmed"
  get "sitemap.:format" => "mains#sitemap"

  mount Monologue::Engine, at: 'estudios'

  localized do
    resources :bills do
      get 'searches', on: :collection
    end

    resources :communications do
      get 'per_person', on: :collection
      get 'per_message', on: :collection
    end

    resources :congressmen do
      get 'searches', on: :collection
      get 'votes', on: :collection
    end

    resources :agendas
    resources :disclosures
    resources :glossaries
    resources :mains
    resources :searches
    resources :sessions
    resources :users
    resources :user_subscriptions # do
      # delete 'unsubscribe_all', on: :collection
    # end
    root :to => "mains#index"
  end
end
