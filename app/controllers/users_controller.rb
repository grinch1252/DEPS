class UsersController < ApplicationController
  before_action :user_find, only: [:show, :edit, :update, :following, :followers]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :guest_user_validation, only: [:update]

  def index
    @users = User.where(activeted :true).page(params[:page]).per(7)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:info] = "Created account."
      redirect_to user_path(@user)
    else
      flash[:danger] = "Invalid information."
      redirect_to new_user_path
    end
  end

  def show
    @micropost = current_user.microposts.build
    @microposts = @user.microposts.page(params[:page]).per(7)
    @chart = @user.microposts_period(@period)
    @subjects = @user.subjects.page(params[:page]).per(8)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile has been updated."
      redirect_to @user
    else
      flash[:danger] = "Invalid information."
      redirect_to edit_user_path(@user)
    end
  end

  def following
    @title = "Following"
    @users = @user.following.page(params[:page]).per(7)
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @users = @user.followers.page(params[:page]).per(7)
    render "show_follow"
  end

  def search
    if params[:name].present?
      @users = User.where("name LIKE ?", "%#{params[:name]}%").page(params[:page]).per(7)
    else
      @users = User.none
    end
  end

  def graph
    define_user
    @micropost = @user.microposts.build
    @microposts = @user.microposts
    @period = params[:period]
    @chart = @user.microposts_period(@period)
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

    def user_find
      @user = User.find(params[:id])
    end
end
