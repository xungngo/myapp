class Event < ActiveRecord::Base
  #has_many :event_attachment_mappings
  #has_many :attachments, :through => :event_attachment_mappings
  has_many :attachments, :dependent => :destroy
  #has_and_belongs_to_many :eventdates
  has_many :eventdates_events
  has_many :eventdates, :through => :eventdates_events
  belongs_to :eventtype
  belongs_to :eventattendeetype

  validates :name, presence: {message: "The Event Name field is required."}
  validates :description, presence: {message: "The Event Description field is required."}
  validates :address, presence: {message: "The Event Address field is required."}
  validates :latitude, presence: {message: "The Event Address field is not mappable."}, if: :address?
  # validates :longitude, presence: {message: "The Event Address field is required."}
  validates :eventtype_id, presence: {message: "The Event Type field is required."}
  validates :uuid, presence: {message: "The Event UUID is required."}

  def pretty_active
    self.active ? "Active" : "Inactive"
  end
end
