class RootController < ApplicationController
  def show
    if current_user
      redirect_to user_dashboard
    else
      redirect_to login_path
    end
  end
end
