module CompanyHelpers
  extend ActiveSupport::Concern

  def created_at_formatted
    return nil unless created_at.present?
    created_at.strftime("%m/%d/%Y @ %l:%M %p")
  end

  def updated_at_formatted
    return nil unless updated_at.present?
    updated_at.strftime("%m/%d/%Y @ %l:%M %p")
  end
end