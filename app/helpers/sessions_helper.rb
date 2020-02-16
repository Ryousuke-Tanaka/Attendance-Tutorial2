module SessionsHelper
	
	# 引数に渡されたユーザーオブジェクトでログインします。
	def log_in(user)
		session[:user_id] = user.id
	end
	
	# セッションと#current_userを破棄します
	def log_out
		session.delete(:user_id)
		@current_user = nil	# current_userメソッドに残った@current_userに代入されたユーザーオブジェクトを破棄する必要がある。
	end
	
	# 現在ログイン中のユーザーがいる場合オブジェクトを返します。
	def current_user
		if session[:user_id]
			@current_user ||=  User.find_by(id: session[:user_id])
		else
			@current_user
		end
	end
	
	# 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返す。
	def logged_in?	# ログインしていますか？
		!current_user.nil?	# ログインしていればnilじゃない。
	end
end
