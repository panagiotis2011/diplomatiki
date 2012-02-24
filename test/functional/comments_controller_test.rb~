# encoding: utf-8
require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  # create
  test "should not create comment anonymous" do
    assert_no_difference('Comment.count', 'Comment count has changed but should not') do
      post :create, :article_id => articles(:seven).id, :comment => { :student_id => students(:student2).id, :body => 'Comment' }
    end
    assert_redirected_to new_student_session_path
  end
  test "should create comment signed in" do
    sign_in students(:student2)
    assert_difference('Comment.count', 1, 'Comment count has not changed') do
      post :create, :article_id => articles(:seven).id, :comment => { :student_id => students(:student2).id, :body => 'Comment' }
    end
    assert_redirected_to article_path(assigns(:article))
    assert_equal 'Το σχόλιο δημιουργήθηκε με επιτυχία.', flash[:notice]
  end
  test "should not create comment not assigned to article" do
    sign_in students(:student2)
    assert_raises(ActiveRecord::RecordNotFound) do
      assert_no_difference('Comment.count', "Comment count has changed but should not") do
        post :create, :article_id => 100, :comment => { :student_id => students(:student2).id, :body => 'Comment' }
      end
    end
  end
  test "should not create comment not assigned to other student" do
    sign_in students(:student2)
    assert_difference('Comment.count', 1, 'Comment count has not changed') do
      post :create, :article_id => articles(:seven).id, :comment => { :student_id => students(:student1).id, :body => 'Comment' }
    end
    assert assigns(:comment).student_id == students(:student2).id, "Comment does not belong to the current student"
  end
  test "should not assign comment to other article" do
    sign_in students(:student2)
    assert_difference('Comment.count', 1, 'Comment count has not changed') do
      post :create, :article_id => articles(:seven).id, :comment => { :article_id => articles(:six).id, :student_id => students(:student2).id, :body => 'Comment' }
    end
    assert_redirected_to article_path(assigns(:article))
    assert_equal 'Το σχόλιο δημιουργήθηκε με επιτυχία.', flash[:notice]
    assert assigns(:comment).article_id ==  articles(:seven).id, "Comment does not belong to the right article"
  end

  test "should create comment for published articles only" do
    sign_in students(:student2)
    assert_no_difference('Comment.count', 'Comment count has changed but should not') do
      post :create, :article_id => articles(:three).id, :comment => { :student_id => students(:student2).id, :body => 'Comment' }
    end
    assert_no_difference('Comment.count', 'Comment count has changed but should not') do
      post :create, :article_id => articles(:four).id, :comment => { :student_id => students(:student2).id, :body => 'Comment' }
    end
    assert_no_difference('Comment.count', 'Comment count has changed but should not') do
      post :create, :article_id => articles(:five).id, :comment => { :student_id => students(:student2).id, :body => 'Comment' }
    end
    assert_difference('Comment.count', 1, 'Comment count has not changed') do
      post :create, :article_id => articles(:six).id, :comment => { :student_id => students(:student2).id, :body => 'Comment' }
    end
    assert_difference('Comment.count', 1, 'Comment count has not changed') do
      post :create, :article_id => articles(:seven).id, :comment => { :student_id => students(:student2).id, :body => 'Comment' }
    end
  end

 # destroy
  test "should not destroy comment anonymous" do
    assert_no_difference('Comment.count') do
      delete :destroy, :article_id => comments(:three).article_id, :id => comments(:three).id
    end
    assert_redirected_to new_student_session_path
  end
  test "should destroy comment signed in" do
    sign_in students(:student2)
    assert_difference('Comment.count', -1) do
      delete :destroy, :article_id => comments(:three).article_id, :id => comments(:three).id
    end
    assert_redirected_to article_path(assigns(:article))
  end
  test "should not destroy comment linked to other student" do
    sign_in students(:student2)
    assert_raises(ActiveRecord::RecordNotFound) do
      assert_no_difference('Comment.count', "Comment count has changed but should not") do
        delete :destroy, :student_id => students(:student1).id, :article_id => comments(:one).id, :id => comments(:one).id
      end
    end
  end
end
