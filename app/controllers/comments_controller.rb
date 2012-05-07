# encoding: utf-8
class CommentsController < ApplicationController
  before_filter :authenticate_student!

  # δημιουργία ενός σχολίου και σύνδεσή του με μία ερώτηση και έναν σπουδαστή
  def create
    @question = Question.find(params[:question_id])
    @comment = @question.comments.build(params[:comment])
    @comment.student = current_student

    respond_to do |format|
      if @question.state > 2
        if @comment.save
          format.html { redirect_to(@question, :notice => 'Το σχόλιο δημιουργήθηκε με επιτυχία.') }
        else
          format.html { redirect_to(@question, :notice => 'Υπάρχει κάποιο σφάλμα και δεν αποθηκεύτηκε το σχόλιο.') }
        end
      else
        format.html { redirect_to(@question, :notice => 'Τα σχόλια μπορούν να γίνουν μόνο σε δημοσιευμένες ερωτήσεις.') }
      end
    end
  end

  # διαγραφή ενός σχολίου
  def destroy
    @comment = current_student.comments.find(params[:id])
    @question = Question.find(params[:question_id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @question }
    end
  end
end
