# encoding: utf-8
module ActiveModel
  module MassAssignmentSecurity
    module Sanitizer
      def sanitize(attributes)
        attributes
      end
    end
  end
end
Student.delete_all
Article.delete_all

@student1 = Student.create! :email => 'sch@sch.gr', :password => '12345678', :fullname => 'Παναγιώτης Πετρίδης', :lesson_id => '1', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of Admin'
@student1.confirm!
@student2 = Student.create! :email => 'a6945947888@gmail.com', :password => '12345678', :fullname => 'student Two', :lesson_id => '2', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of student2'
@student2.confirm!
@student3 = Student.create! :email => 'one@diplomatiki.eu', :password => '12345678', :fullname => 'student Two', :lesson_id => '2', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of student2'
@student3.confirm!
@student4 = Student.create! :email => 'two@diplomatiki.eu', :password => '12345678', :fullname => 'student Two', :lesson_id => '2', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of student2'
@student4.confirm!
@student5 = Student.create! :email => 'three@diplomatiki.eu', :password => '12345678', :fullname => 'student Two', :lesson_id => '2', :weburl => 'http://www.diplomatiki.eu', :shortbio => 'Short biography of student2'
@student5.confirm!



@article = @student1.articles.create! :title => 'Article No. 1', :state => 1, :message => '', :submitted => Time.now, :accepted => Time.now + 2.day, :body => "h1. Article 1"
@article = @student1.articles.create! :title => 'Article No. 2', :state => 1, :message => '', :submitted => Time.now, :accepted => Time.now + 2.day, :body => "h1. Article 2"
@article = @student1.articles.create! :title => 'Article No. 3', :state => 2, :message => '', :submitted => Time.now, :accepted => Time.now + 2.day, :body => "h1. Article 3"
@article = @student1.articles.create! :title => 'Article No. 4', :state => 3, :message => '', :submitted => Time.now, :accepted => Time.now + 2.day, :body => "h1. Article 4"
@article = @student1.articles.create! :title => 'Article No. 5', :state => 4, :message => '', :submitted => Time.now, :accepted => Time.now + 2.day, :body => "h1. Article 5"


  Lesson.create :name => ''
  Lesson.create :name => 'ΠΛΣ 50'
  Lesson.create :name => 'ΠΛΣ 51'
  Lesson.create :name => 'ΠΛΣ 60'
  Lesson.create :name => 'ΠΛΣ 61'
