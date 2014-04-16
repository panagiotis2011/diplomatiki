class Writing < ActiveRecord::Base
	belongs_to :user
	belongs_to :exercise
	attr_accessible :writing_date, :exercise_id
end
