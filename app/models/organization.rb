class Organization < ActiveRecord::Base
  #after_save :default_organization

  has_many :company_organizations, :dependent => :destroy
  has_many :companies, :through => :company_organizations

  validates :name, presence: {message: "The Organization Name field is required."}
  #validates :name, uniqueness: {message: "The Organization Name field must be unique."}
  validates :address, presence: {message: "The Organization Address field is required."}
  #validates :address, uniqueness: {message: "The Organization Address field must be unique."}
  validates :latitude, presence: {message: "The Organization Latitude field is required."}
  validates :longitude, presence: {message: "The Organization Longitude field is required."}
  #validate :uniqueness_of_name_per_company

  def pretty_created_at
    self.created_at.nil? ? "" : formatted_ts(self.created_at)
  end

  def pretty_updated_at
    self.updated_at.nil? ? "" : formatted_ts(self.updated_at)
  end

  def create_company_organization!(company_id)
    return if company_id.blank? && self.name.blank?
    company_orgs = Organization.includes(:company_organizations).where("company_organizations.company_id" => company_id)
    duplicate = company_orgs.where("lower(name) = lower(?)", self.name)

    if company_orgs.count >= 20
      errors.add(:base, "Maximum organizations reached.")
      return false
    elsif duplicate.present?
      errors.add(:base, "The Organization Name field must be unique per company.")
      return false
    elsif self.save && self.company_organizations.create(company_id: company_id, organization_id: Organization.last.id)
      company_orgs.where.not(id: self.id).update(defaultorg: "false") if self.defaultorg
      return true
    else
      return false
    end
  end

  def update_company_organization!(company_id)
    return if company_id.blank? && self.name.blank?
    company_orgs = Organization.includes(:company_organizations).where("company_organizations.company_id" => company_id).where.not(id: self.id)
    duplicate = company_orgs.where("lower(name) = lower(?)", self.name)

    if duplicate.present?
      errors.add(:base, "The Organization Name field must be unique per company.")
      return false
    elsif self.save
      company_orgs.update(defaultorg: "false") if self.defaultorg
      return true
    else
      return false
    end
  end

  private

  #this function is in application_helper.rb and in other controllers. Need a universial method in one place.
  def formatted_ts(time_with_zone)
    time_with_zone.strftime("%m/%d/%Y @ %l:%M %p")
  end

  def default_organization
    binding.pry
    #if Organization.find_by(company: current_user.id).count <= 1
    #  self.update(defaultorg: true)
    #else

    #end
  end

  #def uniqueness_of_name_per_company
  #  if self.name.present?
  #    duplicate = Organization.includes(:company_organizations).where("company_organizations.company_id" => 1, name: self.name)
  #    errors.add(:base, "The Organization Name field must be unique per company.") if duplicate.present?
  #  end
  #end
end
