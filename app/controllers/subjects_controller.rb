class SubjectsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:destroy]

  def index
    define_user
    @subjects = @user.subjects.page(params[:page]).per(8)
    @subject = Subject.new
  end

  def create
    define_user
    @subject = @user.subjects.build(subject_params)
    if @subject.save
      redirect_to subjects_path
    else
      flash[:danger] = "Invalid information."
      redirect_to subjects_path
    end
  end

  def show
    define_user
    @subject = Subject.find(params[:id])
    @logs = []
    @user.microposts.each do |micropost|
      if micropost.title == @subject.name
        @logs.append(micropost)
      end
    end
  end

  def edit
    define_user
    @subject = @user.subjects.find_by(id: params[:id])
  end

  def update
    define_user
    @subject = @user.subjects.find_by(id: params[:id])
    if @subject.update_attributes(subject_params)
      flash[:success] = "Subject updated."
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
      @subject = current_user.subjects.find_by(id: params[:id])
      redirect_to root_url if @subject.nil?
    end

end
