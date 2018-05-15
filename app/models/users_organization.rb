class UsersOrganization < ActiveRecord::Base
    belongs_to :user
    belongs_to :organization
    
    validates :user_id, presence: {message: "The User ID is required."}
    validates :organization_id, presence: {message: "The Organization ID is required."}
end
