class Instructors::StudentsController < Instructors::BaseController
  def show
    @student = current_user.students.find(params[:id])
    @assignment = Assignment.new
  end

  def update
    cohort = current_user.flock
    CensusFlock.create_or_update(cohort.census_id)
    flash[:success] = "Successfully imported students from Census."
    redirect_to user_dashboard
  end
end
