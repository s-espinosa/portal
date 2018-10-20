class Instructors::DashboardController < Instructors::BaseController
  def show
    @students = current_user.students if current_user.flock
  end
end
