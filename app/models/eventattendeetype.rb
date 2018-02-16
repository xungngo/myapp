class Eventattendeetype < ActiveRecord::Base
  has_many :events

  validates :name, presence: {message: "The Attendee Type Name field is required."}
  validates :name, uniqueness: {message: "The Attendee Type Name field must be unique."}
end
