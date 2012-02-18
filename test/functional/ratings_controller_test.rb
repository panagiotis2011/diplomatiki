# encoding: utf-8
require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
  # create
  test "should not create rating anonymous" do
    assert_no_difference('Rating.count', 'Rating count has changed but should not') do
      post :create, :article_id => articles(:seven).id, :rating => { :student_id => students(:student2).id, :stars => 4 }
    end
    assert_redirected_to new_student_session_path
  end
  test "should create rating signed in" do
    sign_in students(:student2)
    assert_difference('Rating.count', 1, 'Rating count has not changed') do
      post :create, :article_id => articles(:seven).id, :rating => { :student_id => students(:student2).id, :stars => 4 }
    end
    assert_redirected_to article_path(assigns(:article))
    assert_equal 'Ευχαριστώ που ψήφισες αυτό το άρθρο!', flash[:notice]
  end
  test "should not create rating not assigned to article" do
    sign_in students(:student2)
    assert_raises(ActiveRecord::RecordNotFound) do
      assert_no_difference('Rating.count', "Rating count has changed but should not") do
        post :create, :article_id => 100, :rating => { :student_id => students(:student2).id, :stars => 4 }
      end
    end
  end
  test "should not create rating not assigned to other student" do
    sign_in students(:student2)
    assert_difference('Rating.count', 1, 'Rating count has not changed') do
      post :create, :article_id => articles(:seven).id, :rating => { :student_id => students(:student1).id, :stars => 4 }
    end
    assert assigns(:rating).student_id == students(:student2).id, "Raing does not belong to the current student"
  end
  test "should not assign rating to other article" do
    sign_in students(:student2)
    assert_difference('Rating.count', 1, 'Rating count has not changed') do
      post :create, :article_id => articles(:seven).id, :rating => { :article_id => articles(:six).id, :student_id => students(:student2).id, :stars => 4 }
    end
    assert_redirected_to article_path(assigns(:article))
    assert_equal 'Ευχαριστώ που ψήφισες αυτό το άρθρο!', flash[:notice]
    assert assigns(:rating).article_id ==  articles(:seven).id, "Rating does not belong to the right article"
  end
  test "should create rating for published articles only" do
    sign_in students(:student2)
    assert_no_difference('Rating.count', 'Rating count has changed but should not') do
      post :create, :article_id => articles(:three).id, :rating => { :student_id => students(:student2).id, :stars => 4 }
    end
    assert_no_difference('Rating.count', 'Rating count has changed but should not') do
      post :create, :article_id => articles(:four).id, :rating => { :student_id => students(:student2).id, :stars => 4 }
    end
    assert_no_difference('Rating.count', 'Rating count has changed but should not') do
      post :create, :article_id => articles(:five).id, :rating => { :student_id => students(:student2).id, :stars => 4 }
    end
    assert_difference('Rating.count', 1, 'Rating count has not changed') do
      post :create, :article_id => articles(:six).id, :rating => { :student_id => students(:student2).id, :stars => 4 }
    end
    assert_difference('Rating.count', 1, 'Rating count has not changed') do
      post :create, :article_id => articles(:seven).id, :rating => { :student_id => students(:student2).id, :stars => 4 }
    end
  end

  # update
   test "should not update rating anonymous" do
     put :update, :article_id => articles(:seven).id, :id => ratings(:three).id, :rating => { :student_id => students(:student2).id, :stars => 2 }
     assert_redirected_to new_student_session_path
   end
   test "should update rating signed in" do
     sign_in students(:student2)
     put :update, :article_id => articles(:seven).id, :id => ratings(:three).id, :rating => { :student_id => students(:student2).id, :stars => 2 }
     assert assigns(:rating).stars == 2, "Rating has not changed"
     assert_redirected_to article_path(assigns(:article))
   end
   test "should not update rating linked to other student" do
     sign_in students(:student2)
     assert_raises(ActiveRecord::RecordNotFound) do
       put :update, :article_id => articles(:one).id, :id => ratings(:one).id, :rating => { :student_id => students(:student1).id, :stars => 2 }
     end
   end

  # delete
  test "should not destroy rating anonymous" do
     assert_no_difference('Rating.count') do
       delete :destroy, :article_id => ratings(:three).article_id, :id => ratings(:three).id
     end
     assert_redirected_to new_student_session_path
   end
   test "should destroy rating signed in" do
     sign_in students(:student2)
     assert_difference('Rating.count', -1) do
       delete :destroy, :article_id => ratings(:three).article_id, :id => ratings(:three).id
     end
     assert_redirected_to article_path(assigns(:article))
   end
   test "should not destroy rating linked to other student" do
     sign_in students(:student2)
     assert_raises(ActiveRecord::RecordNotFound) do
       assert_no_difference('Rating.count', "Rating count has changed but should not") do
         delete :destroy, :student_id => students(:student1).id, :article_id => ratings(:one).article_id, :id => ratings(:one).id
       end
     end
   end
end
