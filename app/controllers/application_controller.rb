class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login
  before_filter :set_timezone
  helper_method :current_user
  
  protected
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
  
  def set_timezone
    min = request.cookies["time_zone"].to_i
    Time.zone = ActiveSupport::TimeZone[-min.minutes]
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
  
  def load_meal_codes
    @meal_codes = meal_codes
  end
  
  def meal_codes
    {
      '1. Before Breakfast' => 1,
      '2. After Breakfast' => 2,
      '3. Before Lunch' => 3,
      '4. After Lunch' => 4,
      '5. Before Dinner' => 5,
      '6. After Dinner' => 6,
      '7. Before Bed' => 7
    }
  end
  
end
