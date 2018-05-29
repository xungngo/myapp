class Company < ActiveRecord::Base
  include Stripper
  include CompanyHelpers
  strip_attributes :name, :description, :address, :apt

  has_many :users_companies
  has_many :users, :through => :users_companies

  validates :name, presence: {message: "The Company Name field is required."}
  validates :name, uniqueness: {message: "The Company Name field must be unique."}
  validates :address, presence: {message: "The Company Address field is required."}
  validates :latitude, presence: {message: "Something is wrong with the address. Please try again."}
  validates :longitude, presence: {message: "Something is wrong with the address. Please try again."}

  def pretty_active
    self.active ? "Active" : "Inactive"
  end

  def pretty_created_at
    self.created_at.nil? ? "" : formatted_ts(self.created_at)
  end

  def pretty_updated_at
    self.updated_at.nil? ? "" : formatted_ts(self.updated_at)
  end

  def self.all_options_array
    self.all.order("name ASC").collect {|x| ["#{x.name}", x.id]}
  end

  private

  #this function is in application_helper.rb and in other controllers. Need a universial method in one place.
  def formatted_ts(time_with_zone)
    time_with_zone.strftime("%m/%d/%Y @ %l:%M %p")
  end
end
