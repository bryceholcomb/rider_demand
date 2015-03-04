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
      redirect_to user_path(user), notice: "You have successfully updated your information"
    else
      redirect_to user_path(user), alert: "Invalid information"
    end
  end

  private

  def record_not_found
    redirect_to root_path, notice: "That user doesn't exist"
  end

  def user_params
    params.require(:user).permit(:phone_number)
  end
end
