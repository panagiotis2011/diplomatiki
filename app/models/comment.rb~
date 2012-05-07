class Comment < ActiveRecord::Base
   belongs_to :student
   belongs_to :article

   attr_accessible :body

   validates :student_id, :presence => true
   validates :article_id, :presence => true
   validates :body, :presence => true, :length => { :maximum => 50000 }     # ασφάλεια spam

   default_scope :order => 'comments.created_at asc'
end
