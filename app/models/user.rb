class User < ActiveRecord::Base
  has_many :user_role_mappings
  has_many :roles, :through => :user_role_mappings
  has_many :user_location_mappings
  has_many :locations, :through => :user_location_mappings

  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true  
  validate :validate_user_has_role
  validate :validate_user_has_location
  validate :validate_admin_exists

  #roles defined in one place. Must match what is in the unique_key column of the role table (used in cancancan ability file and other places)
  def admin?
    return !!self.roles.find_by_unique_key('admin')
  end

  def trainee?
    return !!self.roles.find_by_unique_key('trainee')
  end

  def trainer?
    return !!self.roles.find_by_unique_key('trainer')
  end  

=begin
  def self.register(obj)
    new_email = auth_info[:email].downcase.sub('.icam', '.gov')
    user_with_email = User.find_by(:email => new_email, :cis_uuid => nil)

    if user_with_email.blank?
      user = User.new
      user.update_icam_attributes(auth_info, should_save:false)
      user.active = 0
      user.role_ids = [2]
      user.save
      UserMailer.new_user_message(SYSTEM_INBOX_EMAIL_ADDRESS, auth_info[:first_name], auth_info[:last_name]).deliver
      user
    else
      user_with_email.update(:name => auth_info[:email].split('@').first, :cis_uuid => auth_info[:cis_uuid])
      user = user_with_email
    end
  end
=end

  def update_login_info
    self.sign_in_count = self.sign_in_count + 1
    self.last_sign_in_at = Time.current
    self.save
  end

  def status
    self.active ? "Active" : "Inactive"
  end

  #def highest_role
  #  self.roles
  #end

  #def full_name
  #	"#{first_name} #{middle_name} #{last_name}"
  #end

  def full_name_ad_style
    "#{firstname} #{middleinit} #{lastname}"
  end

  private

  def validate_user_has_role
    errors.add(:base, "A user must have at least one role") if self.roles.empty?
  end

  def validate_user_has_location
    errors.add(:base, "A user with Trainee role must have at least one location") if self.locations.empty? && self.trainee?
  end

  def validate_admin_exists
   # If this is the first user being created, ignore this check.  That user will be created
   # as the sys admin
   if User.count > 0
     count = User.joins(:roles).where("roles.unique_key = ?", Role.admin_key).distinct.count
     # If the user WAS the only sys admin, the count will back as 0 even though the save
     # process hasn't fully committed (probably because the saving of the roles occurs in
     # a transaction)
     errors.add(:base, "Cannot remove the last Administrator") if count < 1
   end
  end
end
