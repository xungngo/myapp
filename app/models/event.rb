class Event < ActiveRecord::Base
  has_many :event_attachment_mappings
  has_many :attachments, :through => :event_attachment_mappings
  has_many :event_schedule_mappings
  has_many :schedules, :through => :event_schedule_mappings
  belongs_to :eventtype
  belongs_to :eventattendee

  validates :name, presence: {message: "The Event Name field is required."}
  validates :description, presence: {message: "The Event Description field is required."}
  validates :address, presence: {message: "The Event Name field is required."}
  validates :eventtype_id, presence: {message: "The Event Type field is required."}
  validates :latitude, presence: {message: "The Event Latitude is required."}
  validates :longitude, presence: {message: "The Event Latitude is required."}
  validates :uuid, presence: {message: "The Event UUID is required."}
  validates :uuid, presence: {message: "The Event UUID is required."}

  def pretty_active
    self.active ? "Active" : "Inactive"
  end
end
