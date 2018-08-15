class Instructors::TuringCohortsController < ApplicationController
  def update
    CensusCohort.update_all
    flash[:success] = "Successfully imported cohorts from Census."
    redirect_to user_dashboard
  end
end
