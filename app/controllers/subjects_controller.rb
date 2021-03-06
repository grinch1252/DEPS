class SubjectsController < ApplicationController
  before_action :difine_user, :only => [:index, :create, :show, :edit, :update]
  before_action :logged_in_user, :only => [:index, :create, :edit, :update, :destroy]
  before_action :correct_user, :only => [:destroy]
  before_action :guest_user_validation, :only => [:create, :destroy]

  def index
    @subjects = @user.subjects.page(params[:page]).per(8)
    @subject = Subject.new
  end

  def create
    @subject = @user.subjects.build(subject_params)
    if @subject.save
      redirect_to subjects_path
    else
      flash[:danger] = "Invalid information."
      redirect_to subjects_path
    end
  end

  def show
    @subject = Subject.find(params[:id])
    @microposts = @user.microposts.where("title LIKE ?", "%#{@subject.name}%").page(params[:page]).per(7)
    @records = @microposts.pluck(:created_at, :time)
    @records.each do |record|
      record[0] = record[0].strftime("%Y/%m/%d %H:%M")
    end
    @records = @records.sort
  end

  def edit
    @subject = @user.subjects.find_by(:id => params[:id])
  end

  def update
    @subject = @user.subjects.find_by(:id => params[:id])
    if @subject.update(subject_params)
      flash[:success] = "Subject has been updated."
      redirect_to subjects_path
    else
      flash[:danger] = "Invalid information."
      redirect_to edit_subject_path(@subject)
    end
  end

  def destroy
    @subject.destroy
    redirect_to subjects_path
  end

  private

    def subject_params
      params.require(:subject).permit(:name, :picture, :user_id)
    end

    def correct_user
      @subject = current_user.subjects.find_by(:id => params[:id])
      redirect_to root_url if @subject.nil?
    end

end
