Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'application#go_home'

  devise_for :users, path: '',
                     path_names: { sign_in: 'login',
                                   sign_out: 'logout',
                                   password: 'password',
                                   registration: 'register',
                                   sign_up: 'sign_up' }

  # resources

  resources :users
end
