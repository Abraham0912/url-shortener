Rails.application.routes.draw do
  resources :links
  devise_for :users,
  controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/post-data', to: 'posts#show'
  get '/s/:code', to: 'links#redirect'
end
