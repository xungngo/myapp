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

  def self.update(p, eid)
    # binding.pry
    to_length = p[:eventdate].size.to_i - 1
    (0..to_length).each do |ct|
      if p[:eventdate][ct].present? && p[:eventdate_id][ct].present?
        @new_eventdate = Eventdate.find(p[:eventdate_id][ct]).update(eventdate: Date.strptime(p[:eventdate][ct], '%m/%d/%Y'), starttime: p[:starttime][ct], endtime: p[:endtime][ct])
      elsif p[:eventdate][ct].present?
        @new_eventdate = Eventdate.new(eventdate: Date.strptime(p[:eventdate][ct], '%m/%d/%Y'), starttime: p[:starttime][ct], endtime: p[:endtime][ct])
        @new_eventdate.save
        @new_eventdates_events = EventdatesEvents.new(event_id: eid, eventdate_id: @new_eventdate.id)
        @new_eventdates_events.save
      end
    end
    # loop thru current eventdates and delete if not a field
    curr_evt = JSON.parse(p[:current_eventdates])
    (0..curr_evt.size).each do |sz|
      if curr_evt[sz].present?
        curr_evt_id = curr_evt[sz]['id']
        if !p[:eventdate_id].include?(curr_evt_id.to_s)
          Eventdate.destroy(curr_evt_id)
        end
      end
    end
    #binding.pry

    @new_eventdate
    @new_eventdates_events
  end  

  private

  def formatted_date_pg(dt)
    Date.strptime(dt.gsub('/','-'), "%m-%d-%Y")
  end
end
