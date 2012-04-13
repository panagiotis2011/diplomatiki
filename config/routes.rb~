Diplomatiki::Application.routes.draw do
	devise_for :students, :controllers => { :registrations => "students/registrations" }

	match '/auth/:provider/callback' => 'services#create'
	match '/auth/twitter', :as => :auth_twitter
	match '/auth/facebook', :as => :auth_facebook

	resources :services, :only => [:index, :create, :destroy]

	resources :admin, :only => [:index, :delete] do
		member do
			get 'editreject'
			put 'reject'
			put 'accept'
		end
		collection do
			get 'articles'
		end
	end

	resources :articles do
		collection do
			get 'about'
			get 'all'
			get 'myarticles'
			delete 'destroy'
		end

		member do
			put 'submit'
		end

		resources :comments, :only => [:create, :destroy]
		resources :ratings, :only => [:create, :update, :destroy]
	end

	root :to => 'articles#index'
end
