class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def require_user
  	if !logged_in?
  		flash[:notice] = "Please sign in!"
  		redirect_to sign_in_path
  	end
  end

  def require_admin
    unless current_user.admin?
      flash[:danger] = "You are not authorized to do that"
      redirect_to root_path
    end
  end
end
