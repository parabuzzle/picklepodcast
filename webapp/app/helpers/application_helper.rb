module ApplicationHelper
  
  def logged_in?
    if cookies[:token] == ADMIN_TOKEN
      return true
    end
    return false
  end
  
  def newlines(string)
    return string.gsub("\n","<br/>")
  end
  
end
