class Location < ActiveRecord::Base
  has_many :user_location_mappings
  has_many :users, :through => :user_location_mappings

  validates :code, presence: {message: "The Location Code field is required."}
  validates :code, uniqueness: {message: "The Location Code field must be unique."}
  validates :name, presence: {message: "The Location Name field is required."}
  validates :name, uniqueness: {message: "The Location Name field must be unique."}

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
    self.all.order("fcocode ASC").collect {|x| ["#{x.code} - #{x.name}", x.id]}
  end

  private

  #this function is in application_helper.rb and in other controllers. Need a universial method in one place.
  def formatted_ts(time_with_zone)
    time_with_zone.strftime("%m/%d/%Y @ %l:%M %p")
  end
end
