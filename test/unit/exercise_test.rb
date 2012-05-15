require 'test_helper'

class ExerciseTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should not have empty etitle ebody" do
    exercise = Exercise.new
    assert exercise.invalid?
    assert exercise.errors[:etitle].any?
    assert exercise.errors[:ebody].any?
    assert !exercise.save
  end
 test "should not have a average outside boundaries" do
    exercise = Exercise.new :etitle => "MyString", :ebody => "MyText"
    exercise.save

    exercise.average = -1
    assert !exercise.save
    exercise.average = 'a'
    assert !exercise.save
    exercise.average = 11
    assert !exercise.save

    exercise.average = 0
    assert exercise.save
    exercise.average = 2
    assert exercise.save
    exercise.average = 10
    assert exercise.save
  end

end
