class UsersController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      assign_user_cities(params, user)
      redirect_to user_path(user), notice: "You have successfully updated your information"
    else
      redirect_to user_path(user), alert: "The information you have provided cannot be processed at this time"
    end
  end

  private

  def record_not_found
    redirect_to root_path, notice: "That user doesn't exist"
  end

  def assign_user_cities(parameters, user)
    params[:user][:cities].shift
    params[:user][:cities].each do |id|
      city = City.find(id)
      user.cities << city
    end
  end

  def user_params
    params.require(:user).permit(:phone_number,
                                 :vehicle_photo,
                                 :uber_start_date,
                                 :avg_weekly_rides)
  end
end
