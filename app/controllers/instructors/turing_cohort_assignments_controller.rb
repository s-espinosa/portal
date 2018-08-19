class Instructors::TuringCohortAssignmentsController < ApplicationController
  def create
    cohort = TuringCohort.find(params[:turing_cohort_id])
    project = Project.find(params[:project_id])
    cohort.assign_project(project)
    flash[:success] = "Successfully assigned #{project.name} to #{cohort.name}"
    redirect_to instructors_turing_cohort_path(cohort)
  end
end
