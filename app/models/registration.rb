class Registration < ActiveRecord::Base

  belongs_to :user
  belongs_to :schedule

  validates :guest, presence: {message: "The guest count is required."}
  validates :user_id, presence: {message: "A User is required."}
  validates :schedule_id, presence: {message: "An Event is required."}
end
