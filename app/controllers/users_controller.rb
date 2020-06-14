class UsersController < ApplicationController
  before_action :find_user, only: [:show, :followings, :followers]

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
      flash[:success] = "会員登録が完了しました\r投稿ができるようになります"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @posts = @user.posts.order(created_at: :desc)
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
      params.require(:user).permit(:image, :name, :sex, :age, :email, :password, :password_confirmation)
    end
end
