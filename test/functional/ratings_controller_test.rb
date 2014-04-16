# encoding: utf-8
require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
  # create
  test "should not create rating anonymous" do
    assert_no_difference('Rating.count', 'Rating count has changed but should not') do
      post :create, :question_id => questions(:seven).id, :rating => { :user_id => users(:user2).id, :stars => 4 }
    end
    assert_redirected_to new_user_session_path
  end
  test "should create rating signed in" do
    sign_in users(:user2)
    assert_difference('Rating.count', 1, 'Rating count has not changed') do
      post :create, :question_id => questions(:seven).id, :rating => { :user_id => users(:user2).id, :stars => 4 }
    end
    assert_redirected_to question_path(assigns(:question))
    assert_equal 'Ευχαριστώ που ψήφισες αυτή την ερώτηση!', flash[:notice]
  end
  test "should not create rating not assigned to question" do
    sign_in users(:user2)
    assert_raises(ActiveRecord::RecordNotFound) do
      assert_no_difference('Rating.count', "Rating count has changed but should not") do
        post :create, :question_id => 100, :rating => { :user_id => users(:user2).id, :stars => 4 }
      end
    end
  end
  test "should not create rating not assigned to other user" do
    sign_in users(:user2)
    assert_difference('Rating.count', 1, 'Rating count has not changed') do
      post :create, :question_id => questions(:seven).id, :rating => { :user_id => users(:user1).id, :stars => 4 }
    end
    assert assigns(:rating).user_id == users(:user2).id, "Raing does not belong to the current user"
  end
  test "should not assign rating to other question" do
    sign_in users(:user2)
    assert_difference('Rating.count', 1, 'Rating count has not changed') do
      post :create, :question_id => questions(:seven).id, :rating => { :question_id => questions(:six).id, :user_id => users(:user2).id, :stars => 4 }
    end
    assert_redirected_to question_path(assigns(:question))
    assert_equal 'Ευχαριστώ που ψήφισες αυτή την ερώτηση!', flash[:notice]
    assert assigns(:rating).question_id ==  questions(:seven).id, "Rating does not belong to the right question"
  end
  test "should create rating for published questions only" do
    sign_in users(:user2)
    assert_no_difference('Rating.count', 'Rating count has changed but should not') do
      post :create, :question_id => questions(:three).id, :rating => { :user_id => users(:user2).id, :stars => 4 }
    end
    assert_no_difference('Rating.count', 'Rating count has changed but should not') do
      post :create, :question_id => questions(:four).id, :rating => { :user_id => users(:user2).id, :stars => 4 }
    end
    assert_no_difference('Rating.count', 'Rating count has changed but should not') do
      post :create, :question_id => questions(:five).id, :rating => { :user_id => users(:user2).id, :stars => 4 }
    end
    assert_difference('Rating.count', 1, 'Rating count has not changed') do
      post :create, :question_id => questions(:six).id, :rating => { :user_id => users(:user2).id, :stars => 4 }
    end
    assert_difference('Rating.count', 1, 'Rating count has not changed') do
      post :create, :question_id => questions(:seven).id, :rating => { :user_id => users(:user2).id, :stars => 4 }
    end
  end

  # update
   test "should not update rating anonymous" do
     put :update, :question_id => questions(:seven).id, :id => ratings(:three).id, :rating => { :user_id => users(:user2).id, :stars => 2 }
     assert_redirected_to new_user_session_path
   end
   test "should update rating signed in" do
     sign_in users(:user2)
     put :update, :question_id => questions(:seven).id, :id => ratings(:three).id, :rating => { :user_id => users(:user2).id, :stars => 2 }
     assert assigns(:rating).stars == 2, "Rating has not changed"
     assert_redirected_to question_path(assigns(:question))
   end
   test "should not update rating linked to other user" do
     sign_in users(:user2)
     assert_raises(ActiveRecord::RecordNotFound) do
       put :update, :question_id => questions(:one).id, :id => ratings(:one).id, :rating => { :user_id => users(:user1).id, :stars => 2 }
     end
   end

  # delete
  test "should not destroy rating anonymous" do
     assert_no_difference('Rating.count') do
       delete :destroy, :question_id => ratings(:three).question_id, :id => ratings(:three).id
     end
     assert_redirected_to new_user_session_path
   end
   test "should destroy rating signed in" do
     sign_in users(:user2)
     assert_difference('Rating.count', -1) do
       delete :destroy, :question_id => ratings(:three).question_id, :id => ratings(:three).id
     end
     assert_redirected_to question_path(assigns(:question))
   end
   test "should not destroy rating linked to other user" do
     sign_in users(:user2)
     assert_raises(ActiveRecord::RecordNotFound) do
       assert_no_difference('Rating.count', "Rating count has changed but should not") do
         delete :destroy, :user_id => users(:user1).id, :question_id => ratings(:one).question_id, :id => ratings(:one).id
       end
     end
   end
end
