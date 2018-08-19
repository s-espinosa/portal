class Instructors::ScoresController < Instructors::BaseController
  def new
    @assignment = Assignment.find(params[:assignment_id])
  end

  def create
    assignment = Assignment.find(params[:assignment_id])
    params["assessment"].each do |rubric_id, evaluation|
      assignment.scores.create(rubric_id: rubric_id,
                              value: evaluation["value"],
                              note: evaluation["note"])
    end
    redirect_to instructors_project_path(assignment.project)
  end
end
