class CreateUserRoleMappings < ActiveRecord::Migration[5.0]
  def change
    create_table :user_role_mappings do |t|
      t.integer :user_id
      t.integer :role_id

      t.timestamps null: true
    end
  end
end
