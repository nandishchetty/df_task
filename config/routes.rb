Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  
  namespace :api, defaults: { format: :json } do

    namespace :v1 do
      devise_scope :user do
        resources :registrations, only: [ :create ]
        resource :session, only: [ :create, :destroy ]
        resource :password do
	      put 'reset_password'
	      put 'update'
	    end
    end

      resource :tweet, only: [ :create, :update, :destroy ]
    end
  end
end
