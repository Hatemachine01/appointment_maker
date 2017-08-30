Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



get    '/users/test' => 'users#test', as: 'test'
get    '/users/search' => 'users#search', as: 'search'
get    '/users/calendar' => 'users#calendar', as: 'calendar'
get    '/appointments/:id/personal_info' => 'appointments#personal_info', as: 'personal_info'
get    '/appointments/:id/confirm' => 'appointments#confirm', as: 'confirm'
get    '/users/:user_id/personal' => 'users#personal', as: 'personal'
get    '/login',   to: 'sessions#new'
post   '/login',   to: 'sessions#create'
get    '/users/searcher' => 'users#searcher', as: 'searcher'
delete '/logout',  to: 'sessions#destroy'


root "application#index"



resources :appointments
resources :users 

resources :conversation do
    resources :messages
  end

end

