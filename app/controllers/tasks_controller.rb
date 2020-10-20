class TasksController < ApplicationController

  def index
    @tasks = Task.where(user_id: current_user.id)
  end

  def create
    tasks = Task.new(task_params)
    tasks.save!
    @tasks = Task.where(user_id: current_user.id)
end

def update
    tasks = Task.find(params[:id])
    @tasks = Task.where(user_id: current_user.id)
    tasks.update(task_params)
end

def destroy
    @user = User.find(params[:id])
    tasks = Task.find(params[:id])
    tasks.destroy
    redirect_to user_path(@user)
end

private
def task_params
    params.require(:tasks).permit(:title, :content, :start, :end, :user_id)
end
end
