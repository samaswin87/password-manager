Rails.application.routes.draw do
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
