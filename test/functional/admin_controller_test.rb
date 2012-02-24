# encoding: utf-8
require 'test_helper'

class AdminControllerTest < ActionController::TestCase

  # acceptarticle
  test "should not accept article anonymous" do
    put :accept, :id => articles(:four).id, :value => '0'
    assert !assigns(:article)
    assert_redirected_to new_student_session_path
  end
  test "should not accept article as normal student" do
    sign_in students(:student5)
    put :accept, :id => articles(:four).id, :value => '0'
    assert !assigns(:article)
    assert_redirected_to root_url
  end
  test "should not accept draft article" do
    sign_in students(:student1)
    put :accept, :id => articles(:three).id, :value => '0'
    assert_equal 'Μόνο υποβληθέντα άρθρα μπορούν να δημοσιευθούν.', flash[:notice]
    assert assigns(:article).state == 0, "Article state is not 0 (draft)"
    assert_redirected_to articles_admin_index_path + '?state=1'
  end
  test "should accept article as standard" do
    sign_in students(:student1)
    put :accept, :id => articles(:four).id, :value => '0'
    assert_equal 'Το άρθρο έχει γίνει αποδεκτό.', flash[:notice]
    assert assigns(:article).state == 3, "Article state is not 3 (accepted)"
    assert_redirected_to articles_admin_index_path + '?state=1'
  end
  test "should accept article as standard if no param" do
    sign_in students(:student1)
    put :accept, :id => articles(:four).id
    assert_equal 'Το άρθρο έχει γίνει αποδεκτό.', flash[:notice]
    assert assigns(:article).state == 3, "Article state is not 3 (accepted)"
    assert_redirected_to articles_admin_index_path + '?state=1'
  end
  test "should accept article as featured" do
    sign_in students(:student1)
    put :accept, :id => articles(:four).id, :value => '1'
    assert_equal 'Το άρθρο έχει γίνει αποδεκτό ως προτεινόμενο άρθρο.', flash[:notice]
    assert assigns(:article).state == 4, "Article state is not 4 (featured)"
    assert_redirected_to articles_admin_index_path + '?state=1'
  end

  # edit reject
  test "should not get editreject anonymous" do
    get :editreject, :id => articles(:four).id
    assert_redirected_to new_student_session_path
  end
  test "should not get editreject as normal student" do
    sign_in students(:student5)
    get :editreject, :id => articles(:four).id
    assert_redirected_to root_url
  end
  test "should get editreject" do
    sign_in students(:student1)
    get :editreject, :id => articles(:four).id
    assert_response :success
  end

  # reject article
  test "should not reject article anonymous" do
    put :reject, :id => articles(:four).id, :article => { :message => 'reject' }
    assert !assigns(:article)
    assert_redirected_to new_student_session_path
  end
  test "should not reject article as normal student" do
    sign_in students(:student5)
    put :reject, :id => articles(:four).id, :article => { :message => 'reject' }
    assert !assigns(:article)
    assert_redirected_to root_url
  end
  test "should not reject draft article" do
    sign_in students(:student1)
    put :reject, :id => articles(:three).id, :article => { :message => 'reject' }
    assert assigns(:article).state == 0, "Article state is not 0 (draft)"
    assert_equal 'Μόνο υποβληθέντα άρθρα μπορούν να απορριφθούν.', flash[:notice]
  end
  test "should reject article" do
    sign_in students(:student1)
    put :reject, :id => articles(:four).id, :article => { :message => 'reject' }
    assert assigns(:article).state == 2, "Article state is not 2 (rejected)"
    assert assigns(:article).message == 'reject', "Message has not been set"
    assert assigns(:article).freezebody != '', "Freezebody has not been set"
    assert_redirected_to articles_admin_index_path + '?state=1'
    assert_equal 'Το άρθρο έχει απορριφθεί.', flash[:notice]
  end
end
