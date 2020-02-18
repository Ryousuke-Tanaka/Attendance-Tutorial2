module UsersHelper
	
	# 引数で渡されたユーザーオブジェクトでログインします。
	def log_in(user)
		session[:user_id] = user.id
	end
	
	# 勤怠基本情報を指定のフォーマットで返します。
	def format_basic_info(time)
		format("%.2f",((time.hour * 60) + time.min) / 60.0)
	end
end
