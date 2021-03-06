Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'application#go_home'

  authenticate :user do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end


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

    collection do
      put :import
    end
  end
  resources :passwords do
    member do
      put :status
      put :uploads
      delete :remove_attachment
    end

    collection do
      put :import
    end
  end

  resources :upload, only: [:create] do
    member do
      put :import
    end
  end

  resources :locations do
    collection do
      get :countries
      get :states
      get :cities
    end
  end

  resources :file_imports do
    collection do
      delete :remove_record
    end
  end

  resources :field_mappings do
    collection do
      post :create_or_update
    end
  end

  get 'current_user' => 'application#user'
end
