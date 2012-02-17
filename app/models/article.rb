class Article < ActiveRecord::Base

  belongs_to :student

  attr_accessible :title, :body

  validates :student_id, :presence => true
  validates :title, :presence => true, :length => { :maximum => 80 }
  validates :body, :presence => true
  validates :message, :length => { :maximum => 5000 }
  validates :state, :presence => true, :numericality => true, :inclusion => { :in => 0..4 }
end
