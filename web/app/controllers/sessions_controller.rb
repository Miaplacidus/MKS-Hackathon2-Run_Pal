class SessionsController < ApplicationController
  def create
    user = RunPal.db.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    render :text => "You've logged out"
    redirect_to root_url
  end
end
