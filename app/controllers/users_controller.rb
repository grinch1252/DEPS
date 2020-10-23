class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    @micropost = current_user.microposts.build
    @microposts = @user.microposts.page(params[:page]).per(7)
    @period = params[:period]
    @chart = @user.microposts_period(@period)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      flash[:danger] = "Invalid information."
      redirect_to edit_user_path(@user)
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)
    end

    def logged_in_user
      unless logged_in?
        flash[:warning] = "Please login."
        redirect_to login_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
