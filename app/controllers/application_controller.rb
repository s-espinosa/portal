class ApplicationController < ActionController::Base
  helper_method :current_instructor,
                :user_dashboard

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_instructor
    current_user && current_user.instructor?
  end

  def user_dashboard
    if current_user.instructor?
      instructors_dashboard_path
    else
      dashboard_path
    end
  end
end
