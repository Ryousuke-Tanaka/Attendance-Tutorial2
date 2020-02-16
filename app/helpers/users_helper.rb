module UsersHelper
	
	# 引数で渡されたユーザーオブジェクトでログインします。
	def log_in(user)
		session[:user_id] = user.id
	end
end
