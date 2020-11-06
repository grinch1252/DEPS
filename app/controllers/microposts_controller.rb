class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @user = current_user
    @micropost = @user.microposts.build(micropost_params) if logged_in?
    @microposts = @user.microposts.page(params[:page]).per(7)

    if @micropost.save
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    else
      redirect_to @user
    end
  end

  def destroy
    @user = current_user
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
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
