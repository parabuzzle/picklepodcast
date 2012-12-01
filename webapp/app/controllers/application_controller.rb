class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  def logged_in
    if cookies[:token] == ADMIN_TOKEN
      return true
    else
      flash[:error] = "You are not authorized to do that action."
      redirect_to "/"
      return
    end
  end

end
