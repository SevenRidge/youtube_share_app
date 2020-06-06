class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])
    
    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      flash.now[:danger] = 'Eメールアドレスまたはパスワードが誤っています。'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

  def new_guest
    user = User.guest
    log_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
