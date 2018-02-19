class EventAttachmentMapping < ActiveRecord::Base
	belongs_to :event
	belongs_to :attachment

	validates :event_id, presence: {message: "The Event ID is required."}
	validates :attachment_id, presence: {message: "The Attachment ID is required."}
end
