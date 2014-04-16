require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  test "should not have empty stars" do
    rating = Rating.new
    rating.user_id = 1
    rating.question_id = 1
    assert rating.invalid?
    assert rating.errors[:stars].any?
    assert !rating.save
  end

  test "should belong to user" do
    rating = Rating.new :stars => 4
    rating.question_id = 1
    assert rating.invalid?
    assert !rating.save
  end

  test "should belong to question" do
    rating = Rating.new :stars => 4
    rating.user_id = 1
    assert rating.invalid?
    assert !rating.save
  end

  test "should not have stars outside boundaries" do
    rating = Rating.new
    rating.user_id = 1
    rating.question_id = 1

    rating.stars = -1
    assert !rating.save
    rating.stars = 'a'
    assert !rating.save
    rating.stars = 6
    assert !rating.save

    rating.stars = 0
    assert rating.save
    rating.stars = 2
    assert rating.save
    rating.stars = 5
    assert rating.save
  end
end
