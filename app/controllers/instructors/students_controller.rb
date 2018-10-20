class Instructors::StudentsController < Instructors::BaseController
  def show
    @student = CensusUser.find(params[:id])
    @assignment = Assignment.new
  end

  def update
    cohort = current_user.flock
    CensusFlock.create_or_update(cohort.id)
    flash[:success] = "Successfully imported students from Census."
    redirect_to user_dashboard
  end
end
