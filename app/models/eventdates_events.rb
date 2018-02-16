class EventdatesEvents < ActiveRecord::Base
    # has_many :events
    # has_many :eventdates
    
    validates :event_id, presence: {message: "The Event ID is required."}
    validates :eventdate_id, presence: {message: "The Eventdate ID is required."}
end
