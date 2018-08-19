class Instructors::DashboardController < Instructors::BaseController
  def show
    @students = current_user.students.order(:first_name)
  end
end
