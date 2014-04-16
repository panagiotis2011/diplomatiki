require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  test "should not have empty title body" do
    question = Question.new
    question.user_id = 1
    assert question.invalid?
    assert question.errors[:title].any?
    assert question.errors[:body].any?
    assert !question.save
  end

  test "must belong to a user" do
    question = Question.new :title => "Title", :body => "Body"
    assert question.invalid?
    assert !question.save
  end

  test "should not have a state outside boundaries" do
    question = Question.new :title => "Title", :body => "Body"
    question.user_id = 1

    question.state = -1
    assert !question.save
    question.state = 'a'
    assert !question.save
    question.state = 5
    assert !question.save

    question.state = 0
    assert question.save
    question.state = 2
    assert question.save
    question.state = 4
    assert question.save
  end
end
