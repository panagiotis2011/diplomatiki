# encoding: utf-8
require 'test_helper'

class AdminControllerTest < ActionController::TestCase

  # acceptQuestion
  test "should not accept Question anonymous" do
    put :accept, :id => questions(:four).id, :value => '0'
    assert !assigns(:Question)
    assert_redirected_to new_user_session_path
  end
  test "should not accept Question as normal user" do
    sign_in users(:user2)
    put :accept, :id => questions(:four).id, :value => '0'
    assert !assigns(:Question)
    assert_redirected_to root_url
  end
  test "should not accept draft Question" do
    sign_in users(:user1)
    put :accept, :id => questions(:three).id, :value => '0'
    assert_equal 'Μόνο ερωτήσεις που έχουν υποβληθεί μπορούν να δημοσιευθούν.', flash[:notice]
    assert assigns(:question).state == 0, "Question state is not 0 (draft)"
    assert_redirected_to questions_admin_index_path + '?state=1'
  end
  test "should accept Question as standard" do
    sign_in users(:user1)
    put :accept, :id => questions(:four).id, :value => '0'
    assert_equal 'Η ερώτηση έχει γίνει αποδεκτή.', flash[:notice]
    assert assigns(:question).state == 3, "Question state is not 3 (accepted)"
    assert_redirected_to questions_admin_index_path + '?state=1'
  end
  test "should accept Question as standard if no param" do
    sign_in users(:user1)
    put :accept, :id => questions(:four).id
    assert_equal 'Η ερώτηση έχει γίνει αποδεκτή.', flash[:notice]
    assert assigns(:question).state == 3, "Question state is not 3 (accepted)"
    assert_redirected_to questions_admin_index_path + '?state=1'
  end
  test "should accept Question as featured" do
    sign_in users(:user1)
    put :accept, :id => questions(:four).id, :value => '1'
    assert_equal 'Η ερώτηση έχει γίνει αποδεκτή ως προτεινόμενη ερώτηση.', flash[:notice]
    assert assigns(:question).state == 4, "Question state is not 4 (featured)"
    assert_redirected_to questions_admin_index_path + '?state=1'
  end

  # edit reject
  test "should not get editreject anonymous" do
    get :editreject, :id => questions(:four).id
    assert_redirected_to new_user_session_path
  end
  test "should not get editreject as normal user" do
    sign_in users(:user2)
    get :editreject, :id => questions(:four).id
    assert_redirected_to root_url
  end
  test "should get editreject" do
    sign_in users(:user1)
    get :editreject, :id => questions(:four).id
    assert_response :success
  end

  # reject Question
  test "should not reject Question anonymous" do
    put :reject, :id => questions(:four).id, :question => { :message => 'reject' }
    assert !assigns(:Question)
    assert_redirected_to new_user_session_path
  end
  test "should not reject Question as normal user" do
    sign_in users(:user2)
    put :reject, :id => questions(:four).id, :question => { :message => 'reject' }
    assert !assigns(:Question)
    assert_redirected_to root_url
  end
  test "should not reject draft Question" do
    sign_in users(:user1)
    put :reject, :id => questions(:three).id, :question => { :message => 'reject' }
    assert assigns(:question).state == 0, "Question state is not 0 (draft)"
    assert_equal 'Μόνο ερωτήσεις που έχουν υποβληθεί μπορούν να απορριφθούν.', flash[:notice]
  end
  test "should reject question" do
    sign_in users(:user1)
    put :reject, :id => questions(:four).id, :question => { :message => 'reject' }
    assert assigns(:question).state == 2, "Question state is not 2 (rejected)"
    assert assigns(:question).message == 'reject', "Message has not been set"
    assert assigns(:question).freezebody != '', "Freezebody has not been set"
    assert_redirected_to questions_admin_index_path + '?state=1'
    assert_equal 'Η ερώτηση έχει απορριφθεί.', flash[:notice]
  end
end
