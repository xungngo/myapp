class UserLocationMapping < ActiveRecord::Base
	belongs_to :location
	belongs_to :user

  def self.location_ids(uid)
    self.where(user_id: uid).pluck(:location_id)
  end

  def self.location_fcocode(uid)
    self.where(user_id: uid).includes(:location).pluck(:fcocode)
  end
end
