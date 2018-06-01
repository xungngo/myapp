class Event < ActiveRecord::Base
  before_destroy :destroy_eventdates

  has_many :attachments, dependent: :destroy
  has_many :eventdates_events, dependent: :destroy
  has_many :eventdates, :through => :eventdates_events
  belongs_to :eventtype
  belongs_to :eventattendeetype
  belongs_to :organization

  validates :name, presence: {message: "The Event Name field is required."}
  validates :description, presence: {message: "The Event Description field is required."}
  # validates :address, presence: {message: "The Event Address field is required."}
  validates :eventtype_id, presence: {message: "The Event Type field is required."}
  validates :organization_id, presence: {message: "The Organization field is required."}
  validates :uuid, presence: {message: "The Event UUID is required."}

  def pretty_active
    self.active ? "Active" : "Inactive"
  end

  private

  def destroy_eventdates
    Eventdate.destroy(self.eventdates.ids)
  end
end
