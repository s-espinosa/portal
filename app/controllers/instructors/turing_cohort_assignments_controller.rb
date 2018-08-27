class Instructors::TuringCohortAssignmentsController < ApplicationController
  def create
    cohort = TuringCohort.find(params[:turing_cohort_id])
    project = Project.find(params[:project_id])
    due_date = params[:due_date]
    cohort.assign_project(project, due_date)
    flash[:success] = "Successfully assigned #{project.name} to #{cohort.name}"
    redirect_to instructors_turing_cohort_path(cohort)
  end
end
