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

  def individual_update
    user = CensusUser.update_by_id(params[:id])
    flash[:success] = "Successfully updated #{user.full_name} from Census."
    redirect_to user_dashboard
  end
end
