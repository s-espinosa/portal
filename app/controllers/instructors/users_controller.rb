class Instructors::UsersController < ApplicationController
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Successfully assigned cohort."
    else
      flash[:error] = "Sorry. Something went wrong."
    end
    redirect_to user_dashboard
  end

  private
  def user_params
    params.require(:user).permit(:flock_id)
  end
end
