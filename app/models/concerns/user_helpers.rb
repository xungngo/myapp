module UserHelpers
  extend ActiveSupport::Concern

  def created_at_formatted
    return nil unless created_at.present?
    created_at.strftime("%m/%d/%Y @ %l:%M %p")
  end

  def updated_at_formatted
    return nil unless updated_at.present?
    updated_at.strftime("%m/%d/%Y @ %l:%M %p")
  end

  def profile_updated_at_formatted
    return nil unless profile_updated_at.present?
    profile_updated_at.strftime("%m/%d/%Y @ %l:%M %p")
  end
  
  def preferences_updated_at_formatted
    return nil unless preferences_updated_at.present?
    preferences_updated_at.strftime("%m/%d/%Y @ %l:%M %p")
  end
  
  def security_updated_at_formatted
    return nil unless security_updated_at.present?
    security_updated_at.strftime("%m/%d/%Y @ %l:%M %p")
  end  

  def lastsignin_at_formatted
    return nil unless last_sign_in_at.present?
    last_sign_in_at.strftime("%m/%d/%Y @ %l:%M %p")
  end
end