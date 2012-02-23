Diplomatiki::Application.routes.draw do
	devise_for :students, :controllers => { :registrations => "students/registrations" }

	match '/auth/:provider/callback' => 'services#create'
	resources :services, :only => [:index, :create]
	resources :admin, :only => [:index] do
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
		end

		member do
			put 'submit'
		end

		resources :comments, :only => [:create, :destroy]
		resources :ratings, :only => [:create, :update, :destroy]
	end

	root :to => 'articles#index'
end
