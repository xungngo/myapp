class EventScheduleMapping < ActiveRecord::Base
	belongs_to :event
	belongs_to :schedule

	validates :event_id, presence: {message: "The Event ID is required."}
	validates :schedule_id, presence: {message: "The Schedule ID is required."}
end
