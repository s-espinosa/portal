class SessionsController < ApplicationController
  def new
    render layout: "login"
  end

  def create
    user = CensusUser.create_from_census(request)
    session[:user_id] = user.id
    redirect_to user_dashboard
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
