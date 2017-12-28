class Eventtype < ActiveRecord::Base
  has_many :Events

  validates :name, presence: {message: "The Event Type Name field is required."}
  validates :name, uniqueness: {message: "The Event Type Name field must be unique."}
end
