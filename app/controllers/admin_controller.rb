class AdminController < ApplicationController
  before_filter :authenticate_student!
  before_filter :is_admin

	def index
		@num_state0 = Article.where(:state => '0').count
		@num_state1 = Article.where(:state => '1').count
		@num_state2 = Article.where(:state => '2').count
		@num_state3 = Article.where(:state => '3').count
		@num_state4 = Article.where(:state => '4').count
		@num_published = @num_state3 + @num_state4
		@num_students = Student.all.count
		@num_students_active30days = Student.where('last_sign_in_at > ?', 30.days.ago).count
		@num_students_created30days = Student.where('created_at > ?', 30.days.ago).count
	end


  # display form to enter reject message
  def editreject
     @article = Article.find(params[:id])
     # only submitted articles can be rejected
     if @article.state != 1
       flash[:notice] = 'Only submitted articles can be rejected.'
       redirect_to :action => 'articles', :state => 1
     end
  end


	# reject the article (updates the article)
	def reject
		@article = Article.find(params[:id])
		if @article.state == 1
			if params[:article][:message]
				@article.state = 2
				@article.message = params[:article][:message]
				@article.freezebody = @article.title + "\n\n" + @article.body + "\n\n"
				if @article.save
					flash[:notice] = "The artile was rejected."
					redirect_to :action => 'articles', :state => 1
				else
					render :action => "editreject"
				end
			else
				flash[:notice] = "No reject without reject message."
				redirect_to :action => 'articles', :state => 1
			end
		else
			flash[:notice] = "Only submitted articles can be rejected."
			redirect_to :action => 'articles', :state => 1
		end
	end


	# accept an article as normal or featured article
	def accept
		@article = Article.find(params[:id])
		# only submitted articles can be accepted
		if @article.state == 1
			@article.state = 3
			flash[:notice] = 'The article has been accepted.'
			if params[:value]
				if params[:value] == '1'
					@article.state = 4
					flash[:notice] = 'The article has been accepted as a featured article.'
				end
			end
			# freeeze
			@article.freezebody = @article.title + "\n\n" + @article.body + "\n\n"
			@article.accepted = Time.now
			# save article
			if !@article.save
				flash[:notice] = 'There was an error while accepting the article.'
			end
		else
			flash[:notice] = 'Only submitted articles can be published.'
		end
		redirect_to :action => 'articles', :state => 1
	end


	def articles
		if params[:state]
			@state = params[:state]
			# invalid parameter? show submitted articles
			if !['0', '1', '2', '3', '4'].index(@state)
				@state = '1'
			end
		else
			# no parameter? show submitted articles
			@state = '1'
		end
		# different sort order for different states; verbose the state for the view
		case @state
			when '0' then @state_name = 'draft'; @order = 'updated_at desc'
			when '1' then @state_name = 'submitted'; @order = 'updated_at desc'
			when '2' then @state_name = 'rejected'; @order = 'updated_at desc'
			when '3' then @state_name = 'accepted'; @order = 'accepted desc'
			when '4' then @state_name = 'featured'; @order = 'accepted desc'
		end
		@articles = Article.where(:state => @state).order(@order)
	end

	protected
	def is_admin
		if current_student
			if current_student.id == 1
				return 1
			end
		end
		redirect_to root_url
	end
end
