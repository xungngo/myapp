class Schedule < ActiveRecord::Base
  # before_destroy :destroy_eventdates

  has_many :eventdates, dependent: :destroy
  has_many :registrations, dependent: :destroy
  belongs_to :event

  validates :name, presence: {message: "The Schedule Name field is required."}
  validates :event_id, presence: {message: "An Event is required."}

  private

  # def destroy_eventdates
  #  Eventdate.destroy(self.eventdates.ids)
  # end
end
