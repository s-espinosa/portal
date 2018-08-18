class Instructors::TuringCohortsController < Instructors::BaseController
  def update
    CensusCohort.update_all
    flash[:success] = "Successfully imported cohorts from Census."
    redirect_to user_dashboard
  end
end
