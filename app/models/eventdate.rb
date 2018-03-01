class Eventdate < ActiveRecord::Base
  has_and_belongs_to_many :events

  validates :eventdate, presence: {message: "The Event Date field is required."}
  validates :starttime, presence: {message: "The Start Time field is required."}
  validates :endtime, presence: {message: "The End Time field is required."}

  def self.create(p, eid)
    to_length = p[:eventdate].size.to_i - 1
    (0..to_length).each do |ct|
      if p[:eventdate][ct].present?
        @new_eventdate = Eventdate.new(eventdate: Date.strptime(p[:eventdate][ct], '%m/%d/%Y'), starttime: p[:starttime][ct], endtime: p[:endtime][ct])
        @new_eventdate.save
        @new_eventdates_events = EventdatesEvents.new(event_id: eid, eventdate_id: @new_eventdate.id)
        @new_eventdates_events.save
        #binding.pry
      end
    end
    @new_eventdate
    @new_eventdates_events
  end

  private

  def formatted_date_pg(dt)
    Date.strptime(dt.gsub('/','-'), "%m-%d-%Y")
  end
end
