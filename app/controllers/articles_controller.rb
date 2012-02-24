# encoding: utf-8
class ArticlesController < ApplicationController
	# μόνο οι μέθοδοι index, all, about και show είναι προσβάσιμες από μη πιστοποιημένους χρήστες
	before_filter :authenticate_student!, :except => [:index, :all, :show, :about]
	rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found


	def index
		@articles = Article.where(:state => '4').paginate(:page => params[:page], :per_page => 10)
		respond_to do |format|
			format.html  # index.html.erb
			format.xml  { render :xml => @articles }
		end
	end


	def all
		@articles = Article.where(:state => ['3', '4']).search(params[:search]).order('accepted desc').paginate(:page => params[:page], :per_page => 10)
		respond_to do |format|
			format.html { render 'index' }
			format.xml  { render :xml => @articles }
		end
	end


	def myarticles
		@myarticles = current_student.articles.all
		respond_to do |format|
			format.html { render 'myarticles'}
			format.xml  { render :xml => @myarticles }
		end
	end


	def submit
		@article = current_student.articles.find(params[:id])
		# submit μόνο αν το άρθρο είναι σε κατάσταση "πρόχειρο" ή "μη αποδεκτό"
		if (@article.state == 0) or (@article.state == 2)
			@article.state = 1
			@article.submitted = Time.now
			if @article.save
				flash[:notice] = 'Το άρθρο σας υποβλήθηκε με επιτυχία για έγκριση.'
			else
				flash[:error] = 'Υπάρχει ένα σφάλμα κατά την υποβολή του άρθρου.'
			end
		else
			flash[:error] = 'Το άρθρο δεν μπορεί να υποβληθεί.'
		end
		respond_to do |format|
			format.html { redirect_to(:action => 'myarticles') }
			format.xml  { head :ok }
		end
	end


	def show
		@article = Article.find(params[:id])
		@comments = @article.comments.all
		if student_signed_in?
			@rating_currentstudent = @article.ratings.find_by_student_id(current_student.id)
			unless @rating_currentstudent
				@rating_currentstudent = current_student.ratings.new
			end
		end
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @article }
		end
	end


	def new
		@article = current_student.articles.new
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @article }
		end
	end


	def edit
		@article = current_student.articles.find(params[:id])
	end


	def create
		@article = current_student.articles.new(params[:article])
		respond_to do |format|
			if @article.save
				format.html { redirect_to(@article, :notice => 'Το άρθρο δημιουργήθηκε επιτυχώς.') }
				format.xml  { render :xml => @article, :status => :created, :location => @article }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
			end
		end
	end


	def update
		@article = current_student.articles.find(params[:id])

		# Εάν ένα άρθρο έχει ήδη γίνει αποδεκτό ο φοιτητής δεν επιτρέπεται να κάνει αλλαγές στον τίτλο
		if @article.state > 2
			params[:article].delete(:title)
		end
		respond_to do |format|
			if @article.update_attributes(params[:article])
				format.html { redirect_to(@article, :notice => 'Το άρθρο ενημερώθηκε επιτυχώς.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
			end
		end
	end


	def destroy
		@article = current_student.articles.find(params[:id])
		# Ο φοιτητής μπορεί να διαγράψει μόνο άρθρα σε κατάσταση "πρόχειρο", "προς υποβολή" ή "μη αποδεκτό"
		if (@article.state < 3)
			@article.destroy
		else
			flash[:error] = 'Το άρθρο δεν μπορεί να διαγραφεί.'
		end
		respond_to do |format|
			format.html { redirect_to(articles_url) }
			format.xml  { head :ok }
		end
	end

	def about
	end


	protected

	def record_not_found
		flash[:error] = 'Το άρθρο που ζητήσατε δεν βρέθηκε.'
		redirect_to root_url
	end
end
