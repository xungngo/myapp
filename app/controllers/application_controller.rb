class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_filter :set_timezone
  before_action :set_timezone

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user

  def authenticate_user
    redirect_to '/signin' unless current_user
  end

  def email_is_blank(p)
    p[:email].blank? ? true : false
  end

  def firstname_is_blank(p)
    p[:firstname].blank? ? true : false
  end
  
  def lastname_is_blank(p)
    p[:lastname].blank? ? true : false
  end
  
  def password_current_is_blank(p)
      p[:password_current].blank? ? true : false
  end

  def password_digest_is_blank(p)
  p[:password_digest].blank? ? true : false
  end

  def password_not_confirmed(p)
  p[:password_digest] == p[:password_confirmation] ? false : true
  end

  def password_not_valid(p)
  password_format = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x
  p[:password_digest].match(password_format) ? false : true
  end

  private
  
  def set_timezone
    tz = current_user ? current_user.timezone : nil
    Time.zone = tz || ActiveSupport::TimeZone["Eastern Time (US & Canada)"]
  end
end
