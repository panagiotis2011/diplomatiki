module WritingsHelper

	def datel
		@exercise = Exercise.all
		@d = @exercise.writings.last
		@datel = @d.writing_date
	end
end
