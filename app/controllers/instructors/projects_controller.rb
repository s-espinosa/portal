class Instructors::ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
    @rubric  = Rubric.new
  end

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "#{@project.name} successfully created."
      redirect_to instructors_project_path(@project)
    else
      render :new
    end
  end

  private
  def project_params
    params.require(:project).permit(:name)
  end
end
