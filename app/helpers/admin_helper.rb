module AdminHelper

	def admin_signed_in
		if current_user
			if current_user.user_kind == 1
				return 1
			end
		end
	end
end
