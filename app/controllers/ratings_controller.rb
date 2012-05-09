# encoding: utf-8
class RatingsController < ApplicationController
  before_filter :authenticate_user!

  # create a rating
  def create
    @question = Question.find(params[:question_id])
    @rating = @question.ratings.build(params[:rating])
    @rating.user = current_user

    respond_to do |format|
      if @question.state > 2
        if @rating.save
          format.html { redirect_to(@question, :notice => 'Ευχαριστώ που ψήφισες αυτή την ερώτηση!') }
        else
          format.html { redirect_to(@question, :notice => 'Υπάρχει κάποιο λάθος κατά την αποθήκευση της ψήφου σου.') }
        end
      else
        format.html { redirect_to(@question, :notice => 'Η ψηφοφορία περιορίζεται μόνο σε ερωτήσεις που έχουν δημοσιευθεί.') }
      end
    end
  end

  # update a rating
  def update
    @rating = current_user.ratings.find(params[:id])
    @question = Question.find(params[:question_id])

    respond_to do |format|
      if @rating.update_attributes(params[:rating])
        format.html { redirect_to(@question, :notice => 'Ευχαριστώ που ενημέρωσες την ψήφο σου!') }
      else
        format.html { redirect_to(@question, :notice => 'Υπάρχει κάποιο λάθος κατά την αποθήκευση της ψήφου σου.') }
      end
    end
  end

  # remove a rating
  def destroy
    @rating = current_user.ratings.find(params[:id])
    @question = Question.find(params[:question_id])

    @rating.destroy

    respond_to do |format|
      format.html { redirect_to @question }
    end
  end
end
