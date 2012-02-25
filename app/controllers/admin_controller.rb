# encoding: utf-8
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


	# φόρμα για την εισαγωγή του μηνύματος στα άρθρα που είναι μη αποδεκτά
	def editreject
		@article = Article.find(params[:id])
		# Μόνο υποβληθέντα άρθρα μπορούν να απορριφθούν
		if @article.state != 1
			flash[:notice] = 'Μόνο υποβληθέντα άρθρα μπορούν να απορριφθούν.'
			redirect_to :action => 'articles', :state => 1
		end
	end


	# απόρριψη του άρθρου
	def reject
		@article = Article.find(params[:id])
		if @article.state == 1
			if params[:article][:message]
				@article.state = 2
				@article.message = params[:article][:message]
				@article.freezebody = @article.title + "\n\n" + @article.body + "\n\n"
				if @article.save
					flash[:notice] = "Το άρθρο έχει απορριφθεί."
					redirect_to :action => 'articles', :state => 1
				else
					render :action => "editreject"
				end
			else
				flash[:notice] = "Για να απορριφθεί το άρθρο είναι απαραίτητο να σταλεί μήνυμα στον δημιουργό του."
				redirect_to :action => 'articles', :state => 1
			end
		else
			flash[:notice] = "Μόνο υποβληθέντα άρθρα μπορούν να απορριφθούν."
			redirect_to :action => 'articles', :state => 1
		end
	end


	# αποδοχή του άρθρου σαν κανονικό ή σαν προτεινόμενο
	def accept
		@article = Article.find(params[:id])
		# μόνο υποβληθέντα άρθρα μπορούν να γίνουν αποδεκτά
		if @article.state == 1
			@article.state = 3
			flash[:notice] = 'Το άρθρο έχει γίνει αποδεκτό.'
			if params[:value]
				if params[:value] == '1'
					@article.state = 4
					flash[:notice] = 'Το άρθρο έχει γίνει αποδεκτό ως προτεινόμενο άρθρο.'
				end
			end
			# freeeze
			@article.freezebody = @article.title + "\n\n" + @article.body + "\n\n"
			@article.accepted = Time.now
			# αποθήκευση άρθρου
			if !@article.save
				flash[:notice] = 'Υπάρχει κάποιο σφάλμα κατά την αποδοχή του άρθρου.'
			end
		else
			flash[:notice] = 'Μόνο υποβληθέντα άρθρα μπορούν να δημοσιευθούν.'
		end
		redirect_to :action => 'articles', :state => 1
	end


	def articles
		if params[:state]
			@state = params[:state]
			# λανθασμένες παράμετροι δείξε τα προς υποβολή άρθρα
			if !['0', '1', '2', '3', '4'].index(@state)
				@state = '1'
			end
		else
			# καθόλου παράμετροι δείξε τα προς υποβολή άρθρα
			@state = '1'
		end
		# different sort order for different states; verbose the state for the view
		case @state
			when '0' then @state_name = 'Πρόχειρο'; @order = 'updated_at desc'
			when '1' then @state_name = 'Προς υποβολή'; @order = 'updated_at desc'
			when '2' then @state_name = 'Μη αποδεκτό'; @order = 'updated_at desc'
			when '3' then @state_name = 'Αποδεκτό'; @order = 'accepted desc'
			when '4' then @state_name = 'Προτεινόμενο'; @order = 'accepted desc'
		end
		@articles = Article.where(:state => @state).order(@order)
	end

	protected
	def is_admin
		if current_student
			if current_student.id < 5
				return 1
			end
		end
		redirect_to root_url
	end
end
