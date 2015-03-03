class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_auth(auth)
    if user
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in"
      redirect_to predictor_path
    else
      redirect_to root_path
    end
  end

  def auth
    request.env['omniauth.auth']
  end
end
