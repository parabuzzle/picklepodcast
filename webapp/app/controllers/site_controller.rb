class SiteController < ApplicationController
  
  before_filter :logged_in, :only=>:admin
  
  def index
    @title = "Your Everything EDM Podcast"
    @post = Post.last(:conditions => { :draft => false })
  end
  
  def about_the_show
    @title = "About the Show"
  end
  
  def about_the_hosts
    @title = "About the Hosts"
  end
  
  def login
    @title = "login"
    if request.post?
      if params[:user][:password] == ADMIN_PASS
        cookies[:token] = ADMIN_TOKEN
        flash[:error] = "logged in"
        redirect_to "/"
        return
      else
        flash[:error] = "nope."
        return
      end
    end
  end
  
  def logout
    @title = "logout"
    cookies[:token]=nil
    flash[:error] = "logged out"
    redirect_to "/"
    return
  end
  
  def admin
    @title = "Admin Dashboard"
    @posts = Post.all(:conditions => { :draft => true })
  end
  
end
