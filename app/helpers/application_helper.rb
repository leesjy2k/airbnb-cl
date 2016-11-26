module ApplicationHelper

	def current_user
		if user.id == session[:user_id]
			@current.user ||= User.find(session[:user_id])
		end
	end	






end
