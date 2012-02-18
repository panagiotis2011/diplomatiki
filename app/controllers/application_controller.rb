class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_student!, :except => [:index, :all, :show, :about]
  before_filter :count_articles

  def about
  end

  def all
    @articles = Article.where(:state => ['3', '4'])

    respond_to do |format|
      format.html { render 'index' }                  # uses the same view as the default index
      format.xml  { render :xml => @articles }
    end
  end

  protected
    def count_articles
      @num_all = Article.where(:state => ['3', '4']).count.to_s
      @num_featured = Article.where(:state => '4').count.to_s
    end
end
