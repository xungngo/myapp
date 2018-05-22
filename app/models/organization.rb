class Organization < ActiveRecord::Base
  #after_save :default_organization

  has_many :users_organizations
  has_many :users, :through => :users_organizations

  validates :name, presence: {message: "The Organization Name field is required."}
  #validates :name, uniqueness: {message: "The Organization Name field must be unique."}
  validates :address, presence: {message: "The Organization Address field is required."}
  #validates :address, uniqueness: {message: "The Organization Address field must be unique."}
  validates :latitude, presence: {message: "The Organization Latitude field is required."}
  validates :longitude, presence: {message: "The Organization Longitude field is required."}
  #validate :uniqueness_of_name_per_user

  def pretty_created_at
    self.created_at.nil? ? "" : formatted_ts(self.created_at)
  end

  def pretty_updated_at
    self.updated_at.nil? ? "" : formatted_ts(self.updated_at)
  end

  def create_user_organization!(user_id)
    return if user_id.blank? && self.name.blank?
    user_orgs = Organization.includes(:users_organizations).where("users_organizations.user_id" => user_id)
    duplicate = user_orgs.where("lower(name) = lower(?)", self.name)

    if user_orgs.count >= 20
      errors.add(:base, "Maximum organizations reached.")
      return false
    elsif duplicate.present?
      errors.add(:base, "The Organization Name field must be unique per user.")
      return false
    elsif self.save && self.users_organizations.create(user_id: user_id, organization_id: Organization.last.id)
      user_orgs.where.not(id: self.id).update(defaultorg: "false") if self.defaultorg
      return true
    else
      return false
    end
  end

  def update_user_organization!(user_id)
    return if user_id.blank? && self.name.blank?
    user_orgs = Organization.includes(:users_organizations).where("users_organizations.user_id" => user_id).where.not(id: self.id)
    duplicate = user_orgs.where("lower(name) = lower(?)", self.name)
 
    if duplicate.present?
      errors.add(:base, "The Organization Name field must be unique per user.")
      return false
    elsif self.save
      user_orgs.update(defaultorg: "false") if self.defaultorg
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
    #if Organization.find_by(user: current_user.id).count <= 1
    #  self.update(defaultorg: true)
    #else
      
    #end
  end
   
  #def uniqueness_of_name_per_user
  #  if self.name.present?
  #    duplicate = Organization.includes(:users_organizations).where("users_organizations.user_id" => 1, name: self.name)
  #    errors.add(:base, "The Organization Name field must be unique per user.") if duplicate.present?
  #  end
  #end
end
