class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  helper_method :current_user
  
  protected
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def require_login
    not_authenticated unless current_user.present?
  end
  
  def not_authenticated
    flash[:warning] = 'Please login or create an account.'
    redirect_to sign_in_path
  end
end
