class Instructors::RubricsController < Instructors::BaseController
  def create
    @project = Project.find(params[:project_id])
    @rubric = @project.rubrics.new(rubric_params)
    if @rubric.save
      flash[:success] = "Rubric category successfully added to rubric."
      redirect_to instructors_project_path(@project)
    else
      flash[:error] = "Sorry. Something went wrong."
      redirect_to instructors_project_path(@project)
    end
  end

  private
  def rubric_params
    params.require(:rubric).permit(:rubric_category_id, :description, :project_id)
  end
end
