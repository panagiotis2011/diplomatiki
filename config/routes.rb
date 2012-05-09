Diplomatiki::Application.routes.draw do
	devise_for :users, :controllers => { :registrations => "users/registrations" }

	match '/auth/:provider/callback' => 'services#create'
	match '/auth/twitter', :as => :auth_twitter


	resources :services, :only => [:index, :create, :destroy]

	resources :admin, :only => [:index, :delete] do
		member do
			get 'editreject'
			put 'reject'
			put 'accept'
		end
		collection do
			get 'questions'
		end
	end

	resources :questions do
		collection do
			get 'autocomplete_tag_name'
			get 'about'
			get 'all'
			get 'myquestions'
			delete 'destroy'
		end

		member do
			put 'submit'
			get 'postfacebook'
		end

		resources :comments, :only => [:create, :destroy]
		resources :ratings, :only => [:create, :update, :destroy]
	end

	root :to => 'questions#index'
end
