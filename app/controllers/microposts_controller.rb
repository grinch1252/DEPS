class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @user = current_user
    @micropost = current_user.microposts.build(micropost_params) if logged_in?
    @microposts = @user.microposts.page(params[:page]).per(8)

    if @micropost.save
      redirect_to current_user
    else
      redirect_to @user
    end
  end

  def edit
    @micropost = current_user.microposts.find_by(id: params[:id]) || nil
    if @micropost.nil?
      flash[:warning] = "No permission to edit."
      redirect_to root_url
    end
  end

  def update
    @micropost = current_user.microposts.find_by(id: params[:id])
    @micropost.update_attributes(micropost_params)
    if @micropost.save
      flash[:success] = "Save changes."
      redirect_to current_user
    else
      render edit_micropost_path
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Deleted post."
    redirect_to current_user
  end

  private

    def micropost_params
      params.require(:micropost).permit(:title, :time, :content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
