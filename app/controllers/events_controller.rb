class EventsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]

  def index
    @user = current_user
    @events = @user.events.page(params[:page]).per(8)
    @event = Event.new
  end

  def create
    @user = current_user
    @event = current_user.events.build(event_params) if logged_in?
    @events = @user.events.page(params[:page]).per(8)

    if @event.save
      redirect_to events_path
    else
      redirect_to @user
    end
  end

  def edit
    @event = current_user.events.find_by(id: params[:id]) || nil
    if @event.nil?
      flash[:warning] = "No permission to edit."
      redirect_to root_url
    end
  end

  def update
    @event = current_user.events.find_by(id: params[:id])
    @event.update_attributes(micropost_params)
    if @event.save
      flash[:success] = "Save changes."
      redirect_to current_user
    else
      render edit_micropost_path
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Deleted event."
    redirect_to events_path
  end

  private

    def event_params
      params.require(:event).permit(:title, :start, :end, :user_id, :body)
    end

    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end
end
