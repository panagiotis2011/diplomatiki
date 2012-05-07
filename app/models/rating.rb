class Rating < ActiveRecord::Base
  belongs_to :student
  belongs_to :question

  attr_accessible :stars

  validates :student_id, :presence => true
  validates :question_id, :presence => true
  validates :stars, :presence => true, :numericality => true, :inclusion => { :in => 0..5 }
end
