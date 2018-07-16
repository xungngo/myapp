class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.string :name, :limit => 100, null: false
      t.integer :event_id, null: false
      t.timestamps null: true
    end
  end
end
