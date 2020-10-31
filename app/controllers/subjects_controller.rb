class SubjectsController < ApplicationController

  def index
    @user = current_user
    @subjects = @user.subjects,page(params[:page]).per(8)
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      redirect_to subjects_path
    else
      flash[:danger] = "Invalid information."
      redirect_to new_subject_path
    end
  end

  def destroy
    @subject.destroy
    redirect_to subjects_path
  end

  private

    def subject_params
      params.require(:subject).permit(:user_id, :name, :picture)
    end

end
