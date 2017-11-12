class Role < ActiveRecord::Base
  has_many :user_role_mappings
  has_many :users, :through => :user_role_mappings

  def self.admin_key
  	"admin"
  end

  def self.seeker_key
  	"seeker"
  end

  def self.organizer_key
  	"organizer"
  end    
end
