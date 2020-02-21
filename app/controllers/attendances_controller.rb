class AttendancesController < ApplicationController
  before_action :set_user, only: :edit_one_month
  before_action :logged_in_user, only: [:update, :edit_one_month]
  before_action :set_one_month, only: :edit_one_month
  
	UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"
	
	def update
		@user = User.find(params[:user_id])
		@attendance = Attendance.find(params[:id])
		# 出勤時間が未登録であることを判定します。
		if @attendance.started_at.nil?
			if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
				flash[:info] = "おはようございます！"
			else
				flash[:danger] = UPDATE_ERROR_MSG
			end
		elsif @attendance.finished_at.nil?
			if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
				flash[:info] = "お疲れ様でした。"
			else
				flash[:danger] = UPDATE_ERROR_MSG
			end
		end
		redirect_to @user
	end
	
	def edit_one_month
	end
	
	def update_one_month
		ActiveRecord::Base.transaction do	# トランザクションを開始します。
			attendance_params.each do |id, item|
				attendance = Attendance.find(id)
				attendance.update_attributes!(item)
			end
		end
		flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
		redirect_to user_url(date: params[:date])
	rescue ActiveRecord::RecordInvalid	# トランザクションによるエラー分岐です。
	flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
	redirect_to attendances_edit_one_month_user_url(date: params[:date])
	end
	
	private
		# 1ヶ月分の勤怠情報を扱います。
		def attendance_params
			# pramsハッシュ、:userキーハッシュの中、:attendanceesキーハッシュの中、許可するカラムを指定、idを明示してパラメータを配列にする。　
			params.require(:user).permit(attendances: [:started_at, :finished_at, :note])[:attendances]
		end
		
		# beforeフィルター
		
		# 管理者権限、または現在ログインしているユーザーを許可します。
		def admin_or_correct_user
			@user = User.find(params[:user_id]) if @user.blank?
			unless current_user?(@user) || current_user.admin?
				flash[:danger] = "編集権限がありません。"
				redirect_to(root_url)
			end
		end
end
