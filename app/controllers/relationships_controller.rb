class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    @relationship = current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { render json: @relationship}
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { render json: nil}
    end
  end

end
