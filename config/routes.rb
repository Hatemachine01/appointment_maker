Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

get    '/users/:user_id/personal' => 'users#personal', as: 'personal'
get    '/login',   to: 'sessions#new'
post   '/login',   to: 'sessions#create'
delete '/logout',  to: 'sessions#destroy'




root 'users#index'

resources :appointments
resources :users

resources :conversation do
    resources :messages
  end

end

