class Event < ActiveRecord::Base

  has_many :attachments, dependent: :destroy
  has_many :schedules, dependent: :destroy
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
end
