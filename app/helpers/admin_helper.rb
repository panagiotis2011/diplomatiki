module AdminHelper

	def admin_signed_in
		if current_user
			if current_user.id < 5
				return 1
			end
		end
	end
end
