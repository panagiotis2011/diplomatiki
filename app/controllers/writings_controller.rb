# encoding: utf-8
class WritingsController < ApplicationController
def create
  @writing = current_user.writings.build(:exercise_id => params[:exercise_id], :writing_date => params[:writing][:writing_date])

  if @writing.save
    flash[:notice] = "Προστέθηκε η άσκηση."
    redirect_to root_url
  else
    flash[:error] = "Δεν προστέθηκε η άσκηση."
    redirect_to root_url
  end
end

def new
    @writing = current_user.writings.new
    @exercise = Exercise.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @writing }
    end
end

def destroy
  @writing = current_user.writings.find(params[:id])
  @writing.destroy
  flash[:notice] = "Αφαιρέθηκε η άσκηση."
  redirect_to current_user
end

def index
  @writings = Writing.find(:all)
  @date = params[:month] ? Date.parse(params[:month]) : Date.today

end

  # DELETE /writings/1
  # DELETE /writings/1.xml
  def destroy
    @writing = Writing.find(params[:id])
    @writing.destroy

    respond_to do |format|
      format.html { redirect_to(writings_url) }
      format.xml  { head :ok }
    end
  end

    def show
    @writing = Writing.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @writing }
    end
  end

end
