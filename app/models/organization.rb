class Organization < ActiveRecord::Base
  has_many :users_organizations
  has_many :users, :through => :users_organizations

  validates :name, presence: {message: "The Organization Name field is required."}
  validates :name, uniqueness: {message: "The Organization Name field must be unique."}
  validates :address, presence: {message: "The Organization Address field is required."}
  validates :address, uniqueness: {message: "The Organization Address field must be unique."}
  validates :latitude, presence: {message: "The Organization Latitude field is required."}
  validates :latitude, uniqueness: {message: "The Organization Latitude field must be unique."}
  validates :longitude, presence: {message: "The Organization Longitude field is required."}
  validates :longitude, uniqueness: {message: "The Organization Longitude field must be unique."} 

  def pretty_created_at
    self.created_at.nil? ? "" : formatted_ts(self.created_at)
  end

  def pretty_updated_at
    self.updated_at.nil? ? "" : formatted_ts(self.updated_at)
  end

  private

  #this function is in application_helper.rb and in other controllers. Need a universial method in one place.
  def formatted_ts(time_with_zone)
    time_with_zone.strftime("%m/%d/%Y @ %l:%M %p")
  end
end
