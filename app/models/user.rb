require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt
  include Stripper
  include UserHelpers

  strip_attributes :firstname, :middleinit, :lastname, :address1, :address2, :city, :zipcode, :email, :username, :password_digest

  has_many :user_role_mappings
  has_many :roles, :through => :user_role_mappings
  has_many :user_location_mappings
  has_many :locations, :through => :user_location_mappings
  belongs_to :state

  validates :email, uniqueness: {message: "The email is in the system."}, presence: true
  validates :username, uniqueness: {message: "The username has already been taken."}, presence: true  
  validate :validate_user_has_role
  # validate :validate_user_has_location
  validate :validate_admin_exists
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "A valid email is required."
  # metacharacters [, \, ^, $, ., |, ?, *, +, (, and ) need to be escaped with a \
  validates_format_of :firstname, :with => /\A[^0-9`~!@#\$%\^&*+_=\]|\\(){}:;"<>,.?\/]+\z/, message: "A valid firstname is required."
  validates_format_of :middleinit, :with => /\A[^0-9`~!@#\$%\^&*+_=\]|\\(){}:;"<>,.?\/]+\z/, message: "A valid middle initial is required.", :allow_blank => true
  validates_format_of :lastname, :with => /\A[^0-9`~!@#\$%\^&*+_=\]|\\(){}:;"<>,.?\/]+\z/, message: "A valid lastname is required."

  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  validates :password_digest, presence: true
  # validates :password_digest, presence: true, format: { with: PASSWORD_FORMAT, message: "The password format is not valid." }

  # avatar with paperclip
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/, message: 'Avatar should be an image type such as: jpeg, gif, or png.'
  validates_attachment_size :avatar, :less_than => 500.kilobytes, message: 'Avatar file size should be less than 500Kb!'

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

  def self.authenticate(f)
    user = find_by_email(f[:email].downcase)
    return nil unless user && user.password == f[:password_digest]
    user.update_signin_info
    user
  end

  def self.register(f)
    new_user = new(firstname: f[:firstname], lastname: f[:lastname], email: f[:email].downcase,
                   username: create_username_by_email(f[:email]), uuid: SecureRandom.hex, role_ids: 3, state_id: 1)
    new_user.password = f[:password_digest]
    new_user.save
    new_user
  end

  def password
    @password ||= Password.new(password_digest) # decrypt
  end

  def password=(new_password)
    @password = Password.create(new_password) # encrypt
    self.password_digest = @password
  end

  def self.not_validated?(f)
    user = find_by_email(f[:email].downcase)
    return true unless user.validated_at.present?
  end

  def self.validate(uid)
    user = find_by_uuid(uid.downcase)
    return nil unless user
    user.set_validation_date
    user
  end

  def set_validation_date
    return nil unless self.validated_at.blank? # only set the date once
    self.validated_at = Time.now
    self.save
  end

  def self.change_password(f, u)
    current_pw = f[:password_current]
    decrypt_pw = Password.new(u.password_digest)
    return nil unless decrypt_pw == current_pw
    user = u
    user.password = f[:password_digest]
    user.security_updated_at = Time.now
    user.save
    user
  end

  def update_signin_info
    self.sign_in_count = self.sign_in_count + 1
    self.last_sign_in_at = Time.now
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

  def self.username_is_taken(u, i)
    where(username: u).where.not(id: i).present? ? true : false
  end

  def self.email_is_taken(e, i)
    where(email: e).where.not(id: i).present? ? true : false
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

  def self.create_username_by_email(e)
    username = e.split("@")[0].downcase
    return username unless User.find_by_username(username)
    username + rand(10..99).to_s
  end
end
