class Marker < ActiveRecord::Base

  validates :name, uniqueness: true, presence: true
  validates :address, uniqueness: true, presence: true
  validates :latitude, uniqueness: false, presence: true
  validates :longitude, uniqueness: false, presence: true

end