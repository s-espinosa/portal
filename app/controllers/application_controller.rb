class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_dashboard
    if current_user.instructor?
      instructors_dashboard_path
    else
      dashboard_path
    end
  end
end
