class CreateEventdatesEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :eventdates_events do |t|
      t.integer :event_id, index: true
      t.integer :eventdate_id, index: true
      t.timestamps null: true
    end
  end
end
