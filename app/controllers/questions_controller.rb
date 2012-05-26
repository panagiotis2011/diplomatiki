# encoding: utf-8
class QuestionsController < ApplicationController
	respond_to :json
	autocomplete :tag, :name
	# μόνο οι μέθοδοι index, all, about και show είναι προσβάσιμες από μη πιστοποιημένους χρήστες
	before_filter :authenticate_user!, :except => [:index, :all, :about]
	rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found


	def tag_cloud
		@tags ||= Question.tag_counts_on(:tags)
	end


	def index
		options = {} # εδώ οποιαδήποτε συνθήκη search/pagination
		@tags = Question.tag_counts_on(:tags).limit(8).order('count desc')
		klass = Question
		klass = klass.tagged_with(@tag) if (@tag = params[:tag]).present?
		@questions = klass.where(:state => '4').paginate(:page => params[:page])
		#@questions = Question.where(:state => '4').paginate(:page => params[:page], :per_page => 10)
		respond_to do |format|
			format.html  # index.html.erb
			format.xml  { render :xml => @questions }
		end
	end


	def all
		options = {} # εδώ οποιαδήποτε συνθήκη search/pagination
		@tags = Question.tag_counts_on(:tags)
		klass = Question
		klass = klass.tagged_with(@tag) if (@tag = params[:tag]).present?
		@questions = klass.where(:state => ['3', '4']).search(params[:search]).order('accepted desc').paginate(:page => params[:page], :per_page => 10)
		#@questions = Question.where(:state => ['3', '4']).search(params[:search]).order('accepted desc').paginate(:page => params[:page], :per_page => 10)
		respond_to do |format|
			format.html { render 'index' }
			format.xml  { render :xml => @questions }
		end
	end


	def myquestions
		@myquestions = current_user.questions.all
		respond_to do |format|
			format.html { render 'myquestions'}
			format.xml  { render :xml => @myquestions }
		end
	end


	def auto_complete_for_link_tag_list
		@tags = Link.tag_counts_on(:tags).where('tags.name LIKE ?', params[:link][:tag_list])
		render :inline => "<%= auto_complete_result(@tags, 'name') %>", :layout => false
		logger.info "#{@tags.size} tags found."
	end


	def submit
		@question = current_user.questions.find(params[:id])
		# submit μόνο αν η ερώτηση είναι σε κατάσταση "πρόχειρη" ή "μη αποδεκτή"
		if (@question.state == 0) or (@question.state == 2)
			@question.state = 1
			@question.submitted = Time.now
			if @question.save
				flash[:notice] = 'Η ερώτησή σας υποβλήθηκε με επιτυχία για έγκριση.'
			else
				flash[:error] = 'Υπάρχει ένα σφάλμα κατά την υποβολή της ερώτησης.'
			end
		else
			flash[:error] = 'Η ερώτηση δεν μπορεί να υποβληθεί.'
		end
		respond_to do |format|
			format.html { redirect_to(:action => 'myquestions') }
			format.xml  { head :ok }
		end
	end


	def show
		@question = Question.find(params[:id])
		@comments = @question.comments.all
		if user_signed_in?
			@rating_currentuser = @question.ratings.find_by_user_id(current_user.id)
			unless @rating_currentuser
				@rating_currentuser = current_user.ratings.new
			end
		end
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @question }
		end
	end


	def new
		@question = current_user.questions.new
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @question }
		end
	end


	def postfacebook
		@question = current_user.questions.find(params[:id])
		begin
			current_user.facebook.feed!(
			:message => "Στον Χώρο Συζήτησης Ενημέρωσης δημοσιεύθηκε ερώτηση με τίτλο: #{ @question.title }",
			:name => 'My Rails 3 App with Omniauth, Devise and FB_graph')
			page = FbGraph::Page.new(354024727961476, :access_token => current_user.services.find_by_provider('facebook').token)
			page.feed!(
			:message => "Στον Χώρο Συζήτησης Ενημέρωσης δημοσιεύθηκε ερώτηση με τίτλο: #{ @question.title }",
			:name => 'My Rails 3 App with Omniauth, Devise and FB_graph')
		rescue FbGraph::InvalidToken => e
			case e.message
			when /Error validating access token/
				flash[:alert] = "Σφάλμα επικύρωσης. Θα χρειαστεί εκ νέου αυθεντικοποίηση!"
				respond_to do |format|
					format.html { redirect_to(@question) }
					format.xml  { head :ok }
				end
			when /Duplicate status message/
				flash[:alert] = "Η ερώτηση έχει ήδη δημοσιευθεί στο Facebook!"
				respond_to do |format|
					format.html { redirect_to(@question) }
					format.xml  { head :ok }
				end
			end
		rescue FbGraph::InvalidRequest => e
			case e.message
			when /OAuthException :: Error validating access token/
				flash[:alert] = "Σφάλμα επικύρωσης. Θα χρειαστεί εκ νέου αυθεντικοποίηση!"
				respond_to do |format|
					format.html { redirect_to(@question) }
					format.xml  { head :ok }
				end
			when /Duplicate status message/
				flash[:alert] = "Η ερώτηση έχει ήδη δημοσιευθεί στο Facebook!"
				respond_to do |format|
					format.html { redirect_to(@question) }
					format.xml  { head :ok }
				end
			end
		else
			respond_to do |format|
				format.html { redirect_to( @question, :notice => 'Ο τίτλος της ερώτησης δημοσιεύθηκε με επιτυχία στο Facebook!') }
				format.xml  { head :ok }
			end
		end
	end

	def edit
		@question = current_user.questions.find(params[:id])
	end

	def create
		@question = current_user.questions.new(params[:question])
		respond_to do |format|
			if @question.save
				format.html { redirect_to(@question, :notice => 'Η ερώτηση δημιουργήθηκε επιτυχώς.') }
				format.xml  { render :xml => @question, :status => :created, :location => @question }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
			end
		end
	end


	def update
		@question = current_user.questions.find(params[:id])

		# Εάν μία ερώτηση έχει ήδη γίνει αποδεκτή ο φοιτητής δεν επιτρέπεται να κάνει αλλαγές στον τίτλο
		if @question.state > 2
			params[:question].delete(:title)
		end
		respond_to do |format|
			if @question.update_attributes(params[:question])
				format.html { redirect_to(@question, :notice => 'Η ερώτηση ενημερώθηκε επιτυχώς.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
			end
		end
	end


	def destroy
		# οι καθηγητές μπορούν να διαγράψουν ερωτήσεις σε κάθε κατάσταση
		@question = Question.find(params[:id])
		if current_user.user_kind == 1
			@question.destroy
		else
			@question = current_user.questions.find(params[:id])
			# Ο φοιτητής μπορεί να διαγράψει μόνο ερωτήσεις σε κατάσταση "πρόχειρη", "προς υποβολή" ή "μη αποδεκτή"
			if (@question.state < 3)
				@question.destroy
			else
				flash[:error] = 'Η ερώτηση δεν μπορεί να διαγραφεί.'
			end
		end
		respond_to do |format|
			format.html { redirect_to(questions_url) }
			format.xml  { head :ok }
		end
	end


	def about
	end


	protected
	def record_not_found
		flash[:error] = 'Η ερώτηση που ζητήσατε δεν βρέθηκε.'
		redirect_to root_url
	end

end
