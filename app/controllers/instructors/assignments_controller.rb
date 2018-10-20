class Instructors::AssignmentsController < Instructors::BaseController
  def create
    @student    = CensusUser.find(params[:student_id])
    @assignment = @student.assignments.new(assignment_params)
    if @assignment.save
      flash[:success] = "Successfully assigned #{@assignment.project.name} to #{@student.full_name}"
    else
      flash[:error] = "Sorry. Something went wrong."
    end
    redirect_to instructors_student_path(@student.id)
  end

  private
  def assignment_params
    params.require(:assignment).permit(:project_id)
  end
end
