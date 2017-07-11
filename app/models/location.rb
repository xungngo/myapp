class Location < ActiveRecord::Base
  belongs_to :agency
  belongs_to :directorate
  belongs_to :region
  has_many :user_location_mappings
  has_many :users, :through => :user_location_mappings

  validates :fcocode, presence: {message: "The FCO Code field is required."}
  validates :fcocode, uniqueness: {message: "The FCO Code field must be unique."}
  validates :fconame, presence: {message: "The FCO Name field is required."}
  validates :fconame, uniqueness: {message: "The FCO Name field must be unique."}
  validates_numericality_of :activefile, message: "The ActiveFile field should be an integer.", :only_integer => true

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
    self.all.order("fcocode ASC").collect {|x| ["#{x.fcocode} - #{x.fconame}", x.id]}
  end

  private

  #this function is in application_helper.rb and in other controllers. Need a universial method in one place.
  def formatted_ts(time_with_zone)
    time_with_zone.strftime("%m/%d/%Y @ %l:%M %p")
  end
end
