class Schedule < ActiveRecord::Base
  has_many :event_schedule_mappings
  has_many :events, :through => :event_schedule_mappings

  validates :start, presence: {message: "The Start Date field is required."}
  validates :end, presence: {message: "The End Date field is required."}
end
