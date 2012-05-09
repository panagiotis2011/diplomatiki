class Question < ActiveRecord::Base
  acts_as_taggable_on :tags
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :ratings, :dependent => :destroy

  attr_accessible :title, :body, :tag_list

  validates :user_id, :presence => true
  validates :title, :presence => true, :length => { :maximum => 80 }
  validates :body, :presence => true
  validates :message, :length => { :maximum => 5000 }
  validates :state, :presence => true, :numericality => true, :inclusion => { :in => 0..4 }


  # returns the number of ratings for that question
  def count_ratings
    self.ratings.all.count
  end

  # returns the average rating for that question
  def avg_rating
    @avg = self.ratings.average(:stars)
    @avg ? @avg : 0
  end

  def self.search(search)
  if search
    where('title LIKE ? or body LIKE ?', "%#{search}%", "%#{search}%")
  else
    scoped
  end
end
end
