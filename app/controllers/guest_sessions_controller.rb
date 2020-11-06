class GuestSessionsController < ApplicationController

  def create
    user = User.find_by(email: "guest@deps.org")
    session[:user_id] = user.id
    flash[:success] = "Logged in as Guest User."
    redirect_to user_path(user)
  end
end
