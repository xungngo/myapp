class State < ActiveRecord::Base
  has_many :users

  validates :name, presence: {message: "The State Name field is required."}
  validates :name, uniqueness: {message: "The State Name field must be unique."} 
  validates :abbr, presence: {message: "The State Abbreviation field is required."}
  validates :abbr, uniqueness: {message: "The State Abbreviation field must be unique."} 
end
