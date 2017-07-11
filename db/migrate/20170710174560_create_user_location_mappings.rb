class CreateUserLocationMappings < ActiveRecord::Migration[5.0]
  def change
    create_table :user_location_mappings do |t|
      t.integer :user_id
      t.integer :location_id
      t.timestamps null: true
    end
  end
end
