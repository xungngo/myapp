class CreateEventdates < ActiveRecord::Migration[5.0]
  def change
    create_table :eventdates do |t|
      t.date :eventdate
      t.string :starttime
      t.string :endtime
      t.timestamps null: true
    end
  end
end
