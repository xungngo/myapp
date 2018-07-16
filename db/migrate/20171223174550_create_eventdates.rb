class CreateEventdates < ActiveRecord::Migration[5.0]
  def change
    create_table :eventdates do |t|
      t.date :eventdate, null: false
      t.string :starttime, :limit => 100, null: false
      t.string :endtime, :limit => 100, null: false
      t.integer :schedule_id, null: false
      t.timestamps null: true
    end
  end
end
