class Rating < ActiveRecord::Base
  belongs_to :student
  belongs_to :article

  attr_accessible :stars

  validates :student_id, :presence => true
  validates :article_id, :presence => true
  validates :stars, :presence => true, :numericality => true, :inclusion => { :in => 0..5 }
end
