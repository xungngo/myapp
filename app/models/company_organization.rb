class CompanyOrganization < ActiveRecord::Base
    belongs_to :company
    belongs_to :organization

    validates :company_id, presence: {message: "The Company ID is required."}
    validates :organization_id, presence: {message: "The Organization ID is required."}
end
