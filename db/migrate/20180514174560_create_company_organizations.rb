class CreateCompanyOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :company_organizations do |t|
      t.integer :company_id
      t.integer :organization_id
      t.timestamps null: true
    end
  end
end
