# encoding: utf-8


User.delete_all
Question.delete_all
Lesson.delete_all



module ActiveModel
  module MassAssignmentSecurity
    module Sanitizer
      def sanitize(attributes)
        attributes
      end
    end
  end
end


@lesson1 = Lesson.create! :name => 'ΠΛΣ 50'
#@lesson1.confirm!
@lesson2 = Lesson.create! :name => 'ΠΛΣ 51'
#@lesson2.confirm!
@lesson3 = Lesson.create! :name => 'ΠΛΣ 60'
#@lesson3.confirm!
@lesson4 = Lesson.create! :name => 'ΠΛΣ 61'
#@lesson4.confirm!
@lesson5 = Lesson.create! :name => 'ΠΛΣ 62'
#@lesson5.confirm!
@lesson6 = Lesson.create! :name => ''
#@lesson6.confirm!

@user1 = User.create! :email => 'oneadmin@diplomatiki.gr', :password => '12345678', :fullname => 'admin One', :lesson_id => '2', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Admin', :user_kind => '1'
@user1.confirm!
@user2 = User.create! :email => 'twoadmin@diplomatiki.gr', :password => '12345678', :fullname => 'admin Two', :lesson_id => '3', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Admin2'
@user2.confirm!
@user3 = User.create! :email => 'threeadmin@diplomatiki.gr', :password => '12345678', :fullname => 'admin Three', :lesson_id => '4', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Admin3'
@user3.confirm!
@user4 = User.create! :email => 'fouradmin@diplomatiki.gr', :password => '12345678', :fullname => 'admin Four', :lesson_id => '5', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Admin4'
@user4.confirm!
@user5 = User.create! :email => 'fiveadmin@diplomatiki.gr', :password => '12345678', :fullname => 'admin Five', :lesson_id => '6', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Admin5'
@user5.confirm!
@user6 = User.create! :email => 'foititis@diplomatiki.gr', :password => '12345678', :fullname => 'userone', :lesson_id => '1', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of User1'
@user6.confirm!



@question1 = Question.create! :title => 'Question No. 1', :state => 1, :message => '', :submitted => Time.now - 2.day, :accepted => '', :body => "h1. Question 1", :user_id => 6
@question2 = Question.create! :title => 'Question No. 2', :state => 1, :message => '', :submitted => Time.now - 2.day, :accepted => '', :body => "h1. Question 2", :user_id => 6
@question3 = Question.create! :title => 'Question No. 3', :state => 2, :message => '', :submitted => Time.now - 2.day, :accepted => '', :body => "h1. Question 3", :user_id => 6
@question4 = Question.create! :title => 'Question No. 4', :state => 3, :message => '', :submitted => Time.now - 2.day, :accepted => Time.now, :body => "h1. Question 4", :user_id => 6
@question5 = Question.create! :title => 'Question No. 5', :state => 4, :message => '', :submitted => Time.now - 2.day, :accepted => Time.now, :body => "h1. Question 5", :user_id => 6
