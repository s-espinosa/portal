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

  def edit
    @rubric = Rubric.find(params[:id])
  end

  def update
    @rubric = Rubric.find(params[:id])
    if @rubric.update(rubric_params)
      flash[:success] = "Successfully updated rubric category."
      redirect_to instructors_project_path(@rubric.project)
    else
      flash[:error] = "Sorry. Something went wrong."
      render :edit
    end
  end

  def destroy
    @rubric = Rubric.find(params[:id])
    if @rubric.destroy
      flash[:success] = "Successfully deleted Rubric Category"
      redirect_to instructors_project_path(@rubric.project)
    else
      flash[:error] = "Sorry. Something went wrong."
      redirect_to instructors_project_path(@rubric.project)
    end
  end

  private
  def rubric_params
    params.require(:rubric).permit(:rubric_category_id, :description, :project_id)
  end
end
