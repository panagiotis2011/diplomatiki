# encoding: utf-8
require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase

	setup do
		@question_user1 = questions(:one)
		@question_user6 = questions(:three)
	end


	# index and all
	test "should get index and all anonymous" do
		get :index
		assert_response :success
		assert_not_nil assigns(:questions)
		get :all
		assert_response :success
		assert_not_nil assigns(:questions)
	end
	test "should get index and all signed in" do
		sign_in users(:user6)
		get :index
		assert_response :success
		assert_not_nil assigns(:questions)
		get :all
		assert_response :success
		assert_not_nil assigns(:questions)
	end


	# myquestions
	test "should not get myquestions anonymous" do
		get :myquestions
		assert_redirected_to new_user_session_path
	end
	test "should get myquestions signed in" do
		sign_in users(:user6)
		get :myquestions
		assert_response :success
	end
	test "should not destroy accepted question" do
		sign_in users(:user6)
		assert_no_difference('Question.count', "Question count has changed but should not") do
			delete :destroy, :id => questions(:six).id
		end
		assert_redirected_to questions_path
		assert_equal 'Η ερώτηση δεν μπορεί να διαγραφεί.', flash[:error]
	end
	test "should not destroy featured question" do
		sign_in users(:user6)
		assert_no_difference('Question.count', "Question count has changed but should not") do
			delete :destroy, :id => questions(:seven).id
		end
		assert_redirected_to questions_path
		assert_equal 'Η ερώτηση δεν μπορεί να διαγραφεί.', flash[:error]
	end


	# about
	test "should get about anonymous" do
		get :about
		assert_response :success
	end
	test "should get about signed in" do
		sign_in users(:user6)
		get :about
		assert_response :success
	end


	# show
	test "should show question anonymous" do
		get :show, :id => @question_user1.to_param
		assert_response :success
	end
	test "should show question signed in" do
		sign_in users(:user6)
		get :show, :id => @question_user1.to_param
		assert_response :success
	end


	# new and edit
	test "should not get new and edit anonymous" do
		get :new
		assert_redirected_to new_user_session_path
		get :edit, :id => @question_user1.to_param
		assert_redirected_to new_user_session_path
	end
	test "should get new signed in" do
		sign_in users(:user6)
		get :new
		assert_response :success
	end
	test "new question has to belong to current user" do
		sign_in users(:user6)
		get :new
		assert assigns(:question).user_id == users(:user6).id, "Η ερώτηση δεν ανήκει στον φοιτητή"
	end
	test "should get edit to own question signed in" do
		sign_in users(:user6)
		get :edit, :id => @question_user6.to_param
		assert_response :success
	end
	test "edited question has to belong to current user" do
		sign_in users(:user6)
		get :edit, :id => @question_user1.to_param
		assert_redirected_to root_url, "Should be redirected to root url if question of other user is requested"
		assert_equal 'Η ερώτηση που ζητήσατε δεν βρέθηκε.', flash[:error]
	end


	# create
	test "should not create question anonymous" do
		assert_no_difference('Question.count') do
			post :create, :question => @question_user1.attributes
		end
	end
	test "should not create question linked to other user" do
		sign_in users(:user6)
		post :create, :question => { :user_id => users(:user1).id, :title => 'Title', :body => 'Body' }
		puts assigns(:question).user_id
		assert assigns(:question).user_id == users(:user6).id, "Η ερώτηση δεν ανήκει στον φοιτητή"
	end
	test "should create question signed in" do
		sign_in users(:user6)
		assert_difference('Question.count', 1, "Question count has not changed") do
			post :create, :question => { :user_id => users(:user6).id, :title => 'Title', :body => 'Body' }
		end
		assert_redirected_to question_path(assigns(:question))
		assert_equal 'Η ερώτηση δημιουργήθηκε επιτυχώς.', flash[:notice]
	end


	# update
	test "should not update question anonymous" do
		put :update, :id => @question_user1.to_param, :question => @question_user1.attributes
		assert_redirected_to new_user_session_path
	end
	test "should update question signed in" do
		sign_in users(:user6)
		put :update, :id => @question_user6.to_param, :question => @question_user6.attributes
		assert_redirected_to question_path(assigns(:question))
	end
	test "should not update question linked to other user" do
		sign_in users(:user6)
		put :update, :id => @question_user1.to_param, :question => @question_user1.attributes
		assert_redirected_to root_url, "Should be redirected to root url if question of other user is requested"
		assert_equal 'Η ερώτηση που ζητήσατε δεν βρέθηκε.', flash[:error]
	end


	# submit
	test "should not submit question anonymous" do
		put :submit, :id => @question_user1.to_param
		assert_redirected_to new_user_session_path
	end
	test "should not submit question for other user" do
		sign_in users(:user6)
		put :submit, :id => questions(:one).id
		assert_redirected_to root_url, "Should be redirected to root url if question of other user is requested"
		assert_equal 'Η ερώτηση που ζητήσατε δεν βρέθηκε.', flash[:error]
	end
	test "should submit draft question" do
		sign_in users(:user6)
		put :submit, :id => questions(:three).id
		assert assigns(:question).state == 1, "Question state is not 1 (submitted)"
		assert_redirected_to myquestions_questions_path
		assert_equal 'Η ερώτησή σας υποβλήθηκε με επιτυχία για έγκριση.', flash[:notice]
	end
	test "should resubmit rejected question" do
		sign_in users(:user6)
		put :submit, :id => questions(:five).id
		assert assigns(:question).state == 1, "Question state is not 1 (submitted)"
		assert_redirected_to myquestions_questions_path
		assert_equal 'Η ερώτησή σας υποβλήθηκε με επιτυχία για έγκριση.', flash[:notice]
	end
	test "should not submit submitted question again" do
		sign_in users(:user6)
		put :submit, :id => questions(:four).id
		assert_redirected_to myquestions_questions_path
		assert_equal 'Η ερώτηση δεν μπορεί να υποβληθεί.', flash[:error]
	end
	test "should not submit accepted question again" do
		sign_in users(:user6)
		put :submit, :id => questions(:six).id
		assert_redirected_to myquestions_questions_path
		assert_equal 'Η ερώτηση δεν μπορεί να υποβληθεί.', flash[:error]
	end
	test "should not submit featured question again" do
		sign_in users(:user6)
		put :submit, :id => questions(:seven).id
		assert_redirected_to myquestions_questions_path
		assert_equal 'Η ερώτηση δεν μπορεί να υποβληθεί.', flash[:error]
	end


	# destroy
	test "should not destroy question anonymous" do
		assert_no_difference('Question.count') do
			delete :destroy, :id => @question_user1.to_param
		end
		assert_redirected_to new_user_session_path
	end
	test "should destroy question signed in" do
		sign_in users(:user6)
			assert_difference('Question.count', -1) do
				delete :destroy, :id => @question_user6.to_param
			end
			assert_redirected_to questions_path
		end
	test "should not destroy question linked to other user" do
		sign_in users(:user6)
		assert_no_difference('Question.count', "Question count has changed") do
			delete :destroy, :id => @question_user1.to_param
		end
		assert_redirected_to root_url, "Should be redirected to root url if question of other user is requested"
		assert_equal 'Η ερώτηση που ζητήσατε δεν βρέθηκε.', flash[:error]
	end
end
