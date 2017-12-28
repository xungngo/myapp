class CreateEventScheduleMappings < ActiveRecord::Migration[5.0]
  def change
    create_table :event_schedule_mappings do |t|
      t.integer :event_id
      t.integer :schedule_id

      t.timestamps null: true
    end
  end
end
