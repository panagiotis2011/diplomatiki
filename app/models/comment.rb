class Comment < ActiveRecord::Base
   belongs_to :user
   belongs_to :question

   attr_accessible :body

   validates :user_id, :presence => true
   validates :question_id, :presence => true
   validates :body, :presence => true, :length => { :maximum => 50000 }     # ασφάλεια spam

   default_scope :order => 'comments.created_at asc'
end
