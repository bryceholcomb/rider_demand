class UsersController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    @user = User.find(100)
  end

  private

  def record_not_found
    redirect_to root_path, notice: "That user doesn't exist"
  end
end
