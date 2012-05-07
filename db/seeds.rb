# encoding: utf-8


Student.delete_all
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


@lesson1 = Lesson.create! :name => ''
#@lesson1.confirm!
@lesson2 = Lesson.create! :name => 'ΠΛΣ 50'
#@lesson2.confirm!
@lesson3 = Lesson.create! :name => 'ΠΛΣ 51'
#@lesson3.confirm!
@lesson4 = Lesson.create! :name => 'ΠΛΣ 60'
#@lesson4.confirm!
@lesson5 = Lesson.create! :name => 'ΠΛΣ 61'
#@lesson5.confirm!
@lesson6 = Lesson.create! :name => 'ΠΛΣ 62'
#@lesson6.confirm!

@student1 = Student.create! :email => 'oneadmin@diplomatiki.gr', :password => '12345678', :fullname => 'admin One', :lesson_id => '2', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Admin'
@student1.confirm!
@student2 = Student.create! :email => 'twoadmin@diplomatiki.gr', :password => '12345678', :fullname => 'admin Two', :lesson_id => '3', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Admin2'
@student2.confirm!
@student3 = Student.create! :email => 'threeadmin@diplomatiki.gr', :password => '12345678', :fullname => 'admin Three', :lesson_id => '4', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Admin3'
@student3.confirm!
@student4 = Student.create! :email => 'fouradmin@diplomatiki.gr', :password => '12345678', :fullname => 'admin Four', :lesson_id => '5', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Admin4'
@student4.confirm!
@student5 = Student.create! :email => 'fiveadmin@diplomatiki.gr', :password => '12345678', :fullname => 'admin Five', :lesson_id => '6', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Admin5'
@student5.confirm!
@student6 = Student.create! :email => 'foititis@diplomatiki.gr', :password => '12345678', :fullname => 'student one', :lesson_id => '1', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Student1'
@student6.confirm!


@question1 = Question.create! :title => 'Question No. 1', :state => 1, :message => '', :submitted => Time.now - 2.day, :accepted => '', :body => "h1. Question 1", :student_id => 6
@question2 = Question.create! :title => 'Question No. 2', :state => 1, :message => '', :submitted => Time.now - 2.day, :accepted => '', :body => "h1. Question 2", :student_id => 6
@question3 = Question.create! :title => 'Question No. 3', :state => 2, :message => '', :submitted => Time.now - 2.day, :accepted => '', :body => "h1. Question 3", :student_id => 6
@question4 = Question.create! :title => 'Question No. 4', :state => 3, :message => '', :submitted => Time.now - 2.day, :accepted => Time.now, :body => "h1. Question 4", :student_id => 6
@question5 = Question.create! :title => 'Question No. 5', :state => 4, :message => '', :submitted => Time.now - 2.day, :accepted => Time.now, :body => "h1. Question 5", :student_id => 6
