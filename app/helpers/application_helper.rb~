module ApplicationHelper

	def coderay_dressed(text)
		# the helper has to fix malformatted textile
		# before and after code block there have to be two newlines each for correct textile
		# consume all whitespaces before an after and set two newlines after processing by CodeRay
		text.gsub!(/\s*@@@(\w*?)\s+(.+?)\s*@@@\s*/m) do        # remove the spaces between the @!
			$1 != '' ? @lang = $1 : @lang = 'ruby'
			code = CodeRay.highlight($2, @lang, :css => :class)
			"\n\n<notextile>#{code.strip}</notextile>\n\n"
		end
		return text.html_safe
	end

	def gravatar(email, size)
		gravatar_id = Digest::MD5::hexdigest(email).downcase
		"http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm"
	end

end
