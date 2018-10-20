class Instructors::StudentsController < Instructors::BaseController
  def show
    @student    = CensusUser.find(params[:id])
    @assignment = Assignment.new
  end
end
