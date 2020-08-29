Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'application#go_home'

  devise_for :users, path: '',
                     controllers: {
                      sessions: 'users/sessions',
                      registrations: 'users/registrations'
                     },
                     path_names: { sign_in: 'login',
                                   sign_out: 'logout',
                                   password: 'password',
                                   registration: 'register',
                                   sign_up: 'sign_up' }

  # resources

  resources :users do
    member do
      put :status
    end
  end
  resources :passwords do
    member do
      put :status
    end
  end

  resources :states
  resources :cities
  post 'upload/users' => 'upload#users'
  get 'current_user' => 'application#user'
end
