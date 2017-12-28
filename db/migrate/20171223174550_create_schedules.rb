class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.datetime :start
      t.datetime :end
      t.timestamps null: true
    end
  end
end
