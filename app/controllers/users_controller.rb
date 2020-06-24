class UsersController < ApplicationController
  before_action :find_user, only: [:show, :followings, :followers, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "会員登録が完了しました"
      redirect_to @user
    else
      render :new
      @user = User.new(user_params)
    end
  end

  def show
    @posts = @user.posts.order(created_at: :desc)
  end

  def destroy
    @user.destroy
    flash[:success] = "退会に成功しました"
    redirect_to root_path
  end

  def followings
    @users = @user.followings
    render 'show_followings'
  end

  def followers
    @users = @user.followers
    render 'show_followers'
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:image, :name, :sex, :age, :email, :password, :password_confirmation, :image_cache)
    end
end
