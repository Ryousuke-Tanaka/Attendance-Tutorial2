class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) # メールアドレスがデータベースにあり、かつパスワードが一致するか判定
      log_in user
      # チェックボックスにチェックがあれば「1」が入る。「1」であればrememberメソッドを実行、そうでなければforgetメソッド実行
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) 
      redirect_to user
    else
      flash.now[:danger] = "認証に失敗しました。"
      render :new
    end
  end
  
  def destroy
    # ログイン中の場合のみログアウト処理を実行する。
    log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
