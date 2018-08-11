class Instructors::StudentsController < ApplicationController
  def show
    @student = current_user.students.find(params[:id])
    @assignment = Assignment.new
  end
end
