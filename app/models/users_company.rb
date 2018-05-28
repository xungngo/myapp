class UsersCompany < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  def self.company_ids(uid)
    self.where(user_id: uid).pluck(:company_id)
  end
end
