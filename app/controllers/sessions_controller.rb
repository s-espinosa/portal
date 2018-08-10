class SessionsController < ApplicationController
  def new
  end

  def create
    token       = request.env['omniauth.auth']["credentials"]["token"]
    census_user = Census::Client.new(token: token).get_current_user
    user = User.create_from_census(census_user)
    session[:user_id] = user.id
    redirect_to user_dashboard
  end

  def destroy
    reset_session
    redirect_to login_path
  end
end
