require 'bcrypt'
class User < ActiveRecord::Base
  #has_secure_password
  include BCrypt
  
  has_many :user_role_mappings
  has_many :roles, :through => :user_role_mappings
  has_many :user_location_mappings
  has_many :locations, :through => :user_location_mappings

  validates :email, uniqueness: {message: "The email is in the system."}, presence: true
  validates :username, uniqueness: {message: "The username has already been taken."}, presence: true  
  validate :validate_user_has_role
  # validate :validate_user_has_location
  validate :validate_admin_exists
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "A valid email is required."
  # metacharacters [, \, ^, $, ., |, ?, *, +, (, and ) need to be escaped with a \
  validates_format_of :firstname, :with => /\A[^0-9`~!@#\$%\^&*+_=\]|\\(){}:;"<>,.?\/]+\z/, message: "A valid firstname is required."
  validates_format_of :lastname, :with => /\A[^0-9`~!@#\$%\^&*+_=\]|\\(){}:;"<>,.?\/]+\z/, message: "A valid lastname is required."

  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  validates :password_digest, presence: true, format: { with: PASSWORD_FORMAT, message: "The password format is not valid." }

  #roles defined in one place. Must match what is in the unique_key column of the role table (used in cancancan ability file and other places)
  def admin?
    return !!self.roles.find_by_unique_key('admin')
  end

  def seeker?
    return !!self.roles.find_by_unique_key('seeker')
  end

  def organizer?
    return !!self.roles.find_by_unique_key('organizer')
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

  def self.authenticate(f)
    user = find_by_email(f[:email].downcase)
    return nil unless user && user.password == f[:password_digest]
    user
  end

  def self.register(f)
    new_user = new(firstname: f[:firstname], lastname: f[:lastname], email: f[:email].downcase, 
                   username: create_username(f[:email]), uuid: SecureRandom.hex, role_ids: 3)
    new_user.password = f[:password_digest]
    new_user.save
    #UserMailer.new_user_message(SYSTEM_INBOX_EMAIL_ADDRESS, auth_info[:first_name], auth_info[:last_name]).deliver
    new_user
  end

  def password
    @password ||= Password.new(password_digest) # decrypt
  end

  def password=(new_password)
    @password = Password.create(new_password) # encrypt
    self.password_digest = @password
  end

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

  def self.create_username(n)
    username = n.split("@")[0].downcase
    return username unless User.find_by_username(username)
    username + rand(10..99).to_s
  end  
end
