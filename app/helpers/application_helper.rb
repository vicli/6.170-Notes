module ApplicationHelper

	def hidden_div_if(condition, attributes = {}, &block)
		if condition
		attributes["style"] = "display: none"
		end
		content_tag("div", attributes, &block)
	end

	def current_user
		User.find_by_id(session[:current_user_id])
		
	end
end
