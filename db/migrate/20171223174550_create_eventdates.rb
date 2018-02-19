class CreateEventdates < ActiveRecord::Migration[5.0]
  def change
    create_table :eventdates do |t|
      t.date :eventdate
      t.time :starttime
      t.time :endtime
      t.timestamps null: true
    end
  end
end
