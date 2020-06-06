class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) 
      redirect_to root_path, notice: 'ログインしました'
    else
      flash.now[:danger] = 'Eメールアドレスまたはパスワードが誤っています。'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, notice: 'ログアウトしました'
  end

  def new_guest
    user = User.guest
    log_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end

  # private
  #   def session_params
  #     params.require(:session).permit(:email, :password)
  #   end
end
