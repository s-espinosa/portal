class Instructors::DashboardController < Instructors::BaseController
  def show
    @students = current_user.students
  end
end
