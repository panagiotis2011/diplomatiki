class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_student!, :except => [:index, :all, :show, :about]

  def about
  end

  def all
    @articles = Article.where(:state => ['3', '4'])

    respond_to do |format|
      format.html { render 'index' }                  # uses the same view as the default index
      format.xml  { render :xml => @articles }
    end
  end
end
