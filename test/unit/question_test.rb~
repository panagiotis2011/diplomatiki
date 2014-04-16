require 'test_helper'

class ArticleTest < ActiveSupport::TestCase

  test "should not have empty title body" do
    article = Article.new
    article.student_id = 1
    assert article.invalid?
    assert article.errors[:title].any?
    assert article.errors[:body].any?
    assert !article.save
  end

  test "must belong to a student" do
    article = Article.new :title => "Title", :body => "Body"
    assert article.invalid?
    assert !article.save
  end

  test "should not have a state outside boundaries" do
    article = Article.new :title => "Title", :body => "Body"
    article.student_id = 1

    article.state = -1
    assert !article.save
    article.state = 'a'
    assert !article.save
    article.state = 5
    assert !article.save

    article.state = 0
    assert article.save
    article.state = 2
    assert article.save
    article.state = 4
    assert article.save
  end
end
