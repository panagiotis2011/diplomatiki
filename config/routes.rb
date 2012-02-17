Diplomatiki::Application.routes.draw do
	devise_for :students

	resources :articles do
		collection do
			get 'about'
			get 'all'
			get 'myarticles'
		end

		member do
			put 'submit'
		end
	end

	root :to => 'articles#index'
end
