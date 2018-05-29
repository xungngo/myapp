class CreateUsersOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :users_organizations do |t|
      t.integer :user_id
      t.integer :organization_id
      t.timestamps null: true
    end
  end
end
