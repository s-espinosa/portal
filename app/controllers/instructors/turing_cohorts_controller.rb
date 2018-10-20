class Instructors::TuringCohortsController < Instructors::BaseController
  def index
    @cohorts = TuringCohort.all
  end

  def show
    @cohort = TuringCohort.find(params[:id])
  end

  def create
    cohort = CensusCohort.create_from_name(params[:cohort_name])
    flash[:success] = "Successfully added #{cohort.name}"
    redirect_to instructors_turing_cohorts_path
  end
end
