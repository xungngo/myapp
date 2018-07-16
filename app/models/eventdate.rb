class Eventdate < ActiveRecord::Base
  belongs_to :schedule

  validates :eventdate, presence: {message: "The Event Date field is required."}
  validates :starttime, presence: {message: "The Start Time field is required."}
  validates :endtime, presence: {message: "The End Time field is required."}
  validates :schedule_id, presence: {message: "A Schedule is required."}

  def self.create(p, sid)
    to_length = p[:eventdate].size.to_i - 1
    return if to_length.zero?
    (0..to_length).each do |count|
      if p[:eventdate][count].present?
        @new_eventdate = Eventdate.new(schedule_id: sid, eventdate: Date.strptime(p[:eventdate][count], '%m/%d/%Y'), starttime: p[:starttime][count], endtime: p[:endtime][count])
        @new_eventdate.save
      end
    end
    @new_eventdate
  end

  def self.update(p, sid)
    to_length = p[:eventdate].size.to_i - 1
    return if to_length.zero?
    (0..to_length).each do |count|
      if p[:eventdate][count].present? && p[:eventdate_id][count].present?
        @update_eventdate = Eventdate.find(p[:eventdate_id][count]).update(eventdate: Date.strptime(p[:eventdate][count], '%m/%d/%Y'), starttime: p[:starttime][count], endtime: p[:endtime][count])
      elsif p[:eventdate][count].present?
        @new_eventdate = Eventdate.new(schedule_id: sid, eventdate: Date.strptime(p[:eventdate][count], '%m/%d/%Y'), starttime: p[:starttime][count], endtime: p[:endtime][count])
        @new_eventdate.save
      end
    end

    # loop thru current eventdates and delete if not a field
    curr_evt = JSON.parse(p[:current_eventdates])
    (0..curr_evt.size).each do |count|
      if curr_evt[count].present?
        curr_evt_id = curr_evt[count]['id']
        if !p[:eventdate_id].include?(curr_evt_id.to_s)
          @delete_eventdate = Eventdate.destroy(curr_evt_id)
        end
      end
    end
  end

  private

  def formatted_date_pg(dt)
    Date.strptime(dt.gsub('/','-'), "%m-%d-%Y")
  end
end
