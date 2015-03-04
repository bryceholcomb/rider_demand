class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth(auth)
    if user
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in"
      if user.first_visit == true
        redirect_to edit_user_path(user), notice: "Before we let you go, please provide a little more info so we can help you find more rides!"
      elsif user.first_visit == false
        redirect_to predictor_path
      end
    else
      redirect_to root_path, alert: "Invalid login credentials"
    end
  end

  def auth
    request.env['omniauth.auth']
  end
end
