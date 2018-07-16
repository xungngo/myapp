class CreateRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :registrations do |t|
      t.integer :user_id, null: false
      t.integer :schedule_id, null: false
      t.integer :guest, null: false
      t.timestamps null: true
    end
  end
end
