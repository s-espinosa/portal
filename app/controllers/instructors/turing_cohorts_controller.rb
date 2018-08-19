class Instructors::TuringCohortsController < Instructors::BaseController
  def index
    @cohorts = TuringCohort.all
  end

  def show
    @cohort = TuringCohort.find(params[:id])
  end

  def update
    CensusCohort.update_all
    flash[:success] = "Successfully imported cohorts from Census."
    redirect_to user_dashboard
  end
end
