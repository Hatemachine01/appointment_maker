Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



get    '/conversation/show_sent' => 'conversation#show_sent', as: 'show_sent'
get    '/conversation/untrash' => 'conversation#untrash', as: 'untrash'
get    '/conversation/show_trash' => 'conversation#show_trash', as: 'show_trash'
get    '/application/about' => 'application#about', as: 'about'
get    '/application/restricted' => 'application#restricted', as: 'restricted'
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
  


collection do
      get :inbox
      get :all, action: :index
      get :sent
      get :trash
    end
end


end

