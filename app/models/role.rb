class Role < ActiveRecord::Base
  has_many :user_role_mappings
  has_many :users, :through => :user_role_mappings

  def self.admin_key
  	"sys_admin"
  end

  def self.trainee_key
  	"trainee"
  end

  def self.trainer_key
  	"trainer"
  end    
end
